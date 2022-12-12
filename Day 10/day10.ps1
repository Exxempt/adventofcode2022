$text = Get-Content .\day10.txt

$cycle = 1
$X = 1
$outcome = @()

$text | % {
    $command = $_.Split(" ")

    if ($command[0] -eq "noop") {
        $round = $(New-Object -TypeName PSObject -Property $([ordered]@{
            cycle = $cycle
            value = $X
        }))
        $outcome += $round
        $cycle++
    }
    if ($command[0] -eq "addx") {
        1..2 | % {
            if($_ -eq 1) {
                $round = $(New-Object -TypeName PSObject -Property $([ordered]@{
                    cycle = $cycle
                    value = $X
                }))
                $outcome += $round
            } else {
                $round = $(New-Object -TypeName PSObject -Property $([ordered]@{
                    cycle = $cycle
                    value = $X
                }))
                $outcome += $round
                $X = $X + $command[1]
            }
            $cycle++
        }
    }
}

$part1 = 0
$outcome | where-object  {$_.cycle -eq 20 -or $_.cycle -eq 60 -or $_.cycle -eq 100 -or $_.cycle -eq 140 -or $_.cycle -eq 180 -or $_.cycle -eq 220} | % {
    $part1 = $part1 + ($_.cycle * $_.value)
}

$part1

$screen = ""
$CRT = 0
$outcome | % { 
    [int]$val = $_.value
    $pixels = @(($val - 1),$val,($val + 1))
    $pixels
    if ($CRT -in $pixels) {
        $screen += "#"
    }
    else {
        $screen += "."
    }
    $CRT++
    if ($CRT -ge 40) {
        $CRT = 0
    }
}

#part 2 answer
Write-Host $screen.Substring(0, 40)
Write-Host $screen.Substring(40, 40)
Write-Host $screen.Substring(80, 40)
Write-Host $screen.Substring(120, 40)
Write-Host $screen.Substring(160, 40)
Write-Host $screen.Substring(200, 40)