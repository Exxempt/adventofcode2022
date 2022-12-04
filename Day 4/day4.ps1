$txt = Get-Content ./day4.txt

[int]$part1 = 0
[int]$part2 = 0

$txt | ForEach-Object {

    $val = $_.Split(',')
    $a = $val[0]
    $b = $val[1]

    $c = $a.Split('-')
    $d = $b.Split('-')

    $e = [int]$c[0]..[int]$c[1]
    $f = [int]$d[0]..[int]$d[1]

    $boool = $true
    $boool2 = $true

    $e | % {
        if ($_ -in $f) {} else { $boool = $false }
    }

    $f | % {
        if ($_ -in $e) {} else { $boool2 = $false }
    }

    if ($boool -eq $true -or $boool2 -eq $true) { 
        $part1 = $part1 + 1 
    }

    $check = Compare-Object $e $f -IncludeEqual | Where-Object { $_.sideindicator -eq "==" } | % { $_.inputobject }
    
    if ($check.Count -ne 0) { 
        $part2 = $part2 + 1 
    }
}
#part 1 answer
$part1

#part 2 answer
$part2