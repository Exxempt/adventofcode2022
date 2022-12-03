#region char priority table
[array]$charTable = @()
[int]$number = 1

#lower
for ($i = 0; $i -lt 26; $i++) {
    $char = [char](97 + $i)
    $k = $(New-Object -TypeName PSObject -Property $([ordered]@{
        letter = $char
        priority = $number
    }))
    $charTable += $k
    $number++
}

#upper
for ($i = 0; $i -lt 26; $i++) {
    $char = [char](65 + $i)
    $k = $(New-Object -TypeName PSObject -Property $([ordered]@{
        letter = $char
        priority = $number
    }))
    $charTable += $k
    $number++
}
#endregion

$rucksack = Get-Content ./day3.txt
[int]$num = 0
$rucksack| ForEach-Object {
    $length = $_.Length
    $a = ($_.Substring(0, $length / 2)).ToCharArray()
    $b = ($_.Substring($length - $length / 2)).ToCharArray()  
    $diff = Compare-Object -ReferenceObject $a -DifferenceObject $b -ExcludeDifferent
    $priority = ($charTable | Where-Object {$_.letter -ceq ($diff[0]).InputObject}).priority
    $num += $priority
}

#part 1 answer
$num

$i1 = 0
$i2 = 1
$i3 = 2
[int]$num2 = 0
1..100 | ForEach-Object {

    $x = $rucksack[$i1].ToCharArray()
    $y = $rucksack[$i2].ToCharArray()
    $z = $rucksack[$i3].ToCharArray()
    
    $all = $x + $y + $z
    $diff1 = Compare-Object -ReferenceObject $x -DifferenceObject $y -ExcludeDifferent
    $diff2 = Compare-Object -ReferenceObject $y -DifferenceObject $z -ExcludeDifferent
    
    $value = (Compare-Object -ReferenceObject $diff1 -DifferenceObject $diff2 -Property InputObject -ExcludeDifferent).InputObject
    $answer2 = ($charTable | Where-Object {$_.letter -ceq $value[0]}).priority
    $num2 = $num2 + $answer2
    $i1 = $i1 + 3
    $i2 = $i2 + 3
    $i3 = $i3 + 3
}

#part 2 answer
$num2 



