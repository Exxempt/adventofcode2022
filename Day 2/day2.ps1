#region answer part 1
function calScore ($x, $y) {
    switch ($x) {
        "Rock" {
            if ($y -eq "Rock") {
                $a = 3
            }
            if ($y -eq "Paper") {
                $a = 6
            }
            if ($y -eq "Scissors") {
                $a = 0
            }
        }

        "Paper" {
            if ($y -eq "Rock") {
                $a = 0
            }
            if ($y -eq "Paper") {
                $a = 3
            }
            if ($y -eq "Scissors") {
                $a = 6
            }
        }

        "Scissors" {
            if ($y -eq "Rock") {
                $a = 6
            }
            if ($y -eq "Paper") {
                $a = 0
            }
            if ($y -eq "Scissors") {
                $a = 3
            }
        }

    }

    switch ($y) {
        "Rock" { $b = 1 }
        "Paper" { $b = 2 }
        "Scissors" { $b = 3 }
    }
    return $a + $b 
}

function scoreRPS ($player1, $player2) {
    switch ($player1) {
        "A" { $selection1 = "Rock" }
        "B" { $selection1 = "Paper" }
        "C" { $selection1 = "Scissors" }
    }
    switch ($player2) {
        "X" { $selection2 = "Rock" }
        "Y" { $selection2 = "Paper" }
        "Z" { $selection2 = "Scissors" }
    }
    return calScore $selection1 $selection2
}

$txt = Get-Content "day2.txt"

($txt | ForEach-Object { scoreRPS $_.Substring(0, 1) $_.Substring(2, 1) } | Measure-Object -Sum).Sum
#endregion

#region answer part 2
function adjustChoice ($d, $y) {
    if ($d -eq "Draw") { return $y }
    if ($d -eq "Lose") {
        if ($y -eq "Paper") { return "Rock" }
        if ($y -eq "Rock") { return "Scissors" }
        if ($y -eq "Scissors") { return "Paper" }
    }
    if ($d -eq "Win") {
        if ($y -eq "Paper") { return "Scissors" }
        if ($y -eq "Rock") { return "Paper" }
        if ($y -eq "Scissors") { return "Rock" }
    }
}

function calScore_part2 ($x, $y) {
    switch ($y) {
        "Rock" { $d = "Lose" }
        "Paper" { $d = "Draw" }
        "Scissors" { $d = "Win" }
    }
    switch ($d) {
        "Lose" { $a = 0 }
        "Draw" { $a = 3 }
        "Win" { $a = 6 }
    }

    $z = adjustChoice $d $x
    switch ($z) {
        "Rock" { $b = 1 }
        "Paper" { $b = 2 }
        "Scissors" { $b = 3 }
    }
    return $a + $b 
}

function scoreRPS_part2 ($player1, $player2) {
    switch ($player1) {
        "A" { $selection1 = "Rock" }
        "B" { $selection1 = "Paper" }
        "C" { $selection1 = "Scissors" }
    }
    switch ($player2) {
        "X" { $selection2 = "Rock" }
        "Y" { $selection2 = "Paper" }
        "Z" { $selection2 = "Scissors" }
    }
    return calScore_part2 $selection1 $selection2
}

$txt = Get-Content "day2.txt"

($txt | ForEach-Object { scoreRPS_part2 $_.Substring(0, 1) $_.Substring(2, 1) } | Measure-Object -Sum).Sum
#endregion