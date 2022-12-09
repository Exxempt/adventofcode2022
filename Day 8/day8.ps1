$text = Get-Content "./day8.txt"

function Check-Visability($x,$y) {
    $key = $text[$y][$x]

    [bool]$visable = $false
    [bool]$leftVisable = $true
    [bool]$upVisable = $true
    [bool]$rightVisable = $true
    [bool]$downVisable = $true

    $left = $x - 1
    $up = $y - 1
    $right = $x + 1
    $down = $y + 1

    if ($x -le 0) { $leftVisable = $true} else {
        $left..0 | % {
            $checkLeft = $text[$y][$_]
            if ($checkLeft -ge $key) {
                $leftVisable = $false
            }
        }
    }
    if ($y -le 0) { $upVisable = $true} else {
        $up..0 | % {
            $checkUp = $text[$_][$x]
            if ($checkUp -ge $key) {
                $upVisable = $false
            }
        }
    }
    if ($x -ge 98) { $rightVisable = $true} else {
        $right..98 | % {
            $checkRight = $text[$y][$_]
            if ($checkRight -ge $key) {
                $rightVisable = $false
            }
        }
    }
    if ($y -ge 98) { $downVisable = $true} else { 
        $down..98 | % {
            $checkDown = $text[$_][$x]
            if ($checkDown -ge $key) {
                $downVisable = $false
            }
        }
    }
     if ($leftVisable -eq $true -or $upVisable -eq $true -or $rightVisable -eq $true -or $downVisable -eq $true) {
        $visable = $true
     }

     return $visable
}

[array]$list = @()

0..98 | % {
    $hold = $_
    0..98 | % {
    $round = $(New-Object -TypeName PSObject -Property $([ordered]@{
        row = $hold
        col = $_
    }))
    $list += $round
    }
}

[int]$vis = 0

$list | % {
    $point = Check-Visability $PSItem.row $PSItem.col
    if ($point -eq $true) {
        $vis++
    }
}

#part 1 answer
$vis

function Check-ScenicScore($x,$y) {
    $key = $text[$y][$x]

    [int]$leftVisable = 0
    [int]$upVisable = 0
    [int]$rightVisable = 0
    [int]$downVisable = 0

    [bool]$trip1 = $false
    [bool]$trip2 = $false
    [bool]$trip3 = $false
    [bool]$trip4 = $false

    $left = $x - 1
    $up = $y - 1
    $right = $x + 1
    $down = $y + 1

    if ($x -le 0) { $leftVisable = 0} else {
        $left..0 | % {
            $checkLeft = $text[$y][$_]
            if ($trip1 -eq $false) {
                if ($checkLeft -lt $key) {
                    $leftVisable++
                }
                if ($checkLeft -ge $key) {
                    $leftVisable++
                    $trip1 = $true
                }
            }
        }
    }
    if ($y -le 0) { $upVisable = 0} else {
        $up..0 | % {
            $checkUp = $text[$_][$x]
            if ($trip2 -eq $false) {
                if ($checkUp -lt $key) {
                    $upVisable++
                }
                if ($checkUp -ge $key) {
                    $upVisable++
                    $trip2 = $true
                }
            }
        }
    }
    if ($x -ge 98) { $rightVisable = 0} else {
        $right..98 | % {
            $checkRight = $text[$y][$_]
            if ($trip3 -eq $false) {
            if ($checkRight -lt $key) {
                $rightVisable++
            }
            if ($checkRight -ge $key) {
                $rightVisable++
                $trip3 = $true
            }
            }
        }
    }
    if ($y -ge 98) { $downVisable = 0} else { 
        $down..98 | % {
            $checkDown = $text[$_][$x]
            if ($trip4 -eq $false) {
            if ($checkDown -lt $key) {
                $downVisable++
            }
            if ($checkDown -ge $key) {
                $downVisable++
                $trip4 = $true
            }
            }
        }
    }
    $score = ($leftVisable * $upVisable * $rightVisable * $downVisable)

    return $score
}

[array]$scores = @()

$list | % {
    $sc = Check-ScenicScore $PSItem.row $PSItem.col
    $scores += $sc
}

#part 2 answer
$scores | Sort-Object -Descending | select -First 1