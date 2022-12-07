$txt = Get-Content ./day6.txt
$length = $txt.length
$x = 0
$y = 4

#part 1 answer
1..($length - 3) | ForEach-Object {
    $value = $txt.Substring($x,$y)
    
    $a = $value.ToCharArray()
    $b = $a | Select-Object -Unique
    $check = Compare-Object -ReferenceObject $b -DifferenceObject $a

    if ($check) {
        $x = $x + 1
    }
    else {
        $x + $y
        break
    }
}

$x = 0
$y = 14

#part 2 answer
1..($length - 13) | ForEach-Object {
    $value = $txt.Substring($x,$y)

    $a = $value.ToCharArray()
    $b = $a | Select-Object -Unique
    $check = Compare-Object -ReferenceObject $b -DifferenceObject $a

    if ($check) {
        $x = $x + 1
    }
    else {
        $x + $y
        break
    }
}