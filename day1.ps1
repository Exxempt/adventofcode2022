$txt = Get-Content "Day1.txt"
[array]$list = @()
[int]$val = 0
$txt | ForEach-Object {
    if ($_ -ne "") {
        $val = $val + [int]$_
    }
    else {
        $pack = $(New-Object -TypeName PSObject -Property $([ordered]@{
            Value = $val
        }))
        $list += $pack
        [int]$val = 0
    }
}

#part 1 answer
return $list | Sort-Object Value -Descending | Select-Object -First 1

#part 2 answer
return (($list | Sort-Object Value -Descending | Select-Object -First 3) | Measure-Object -Property Value -Sum).Sum