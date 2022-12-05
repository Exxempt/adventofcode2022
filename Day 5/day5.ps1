#region crate stack
$day5 = Get-Content .\day5.txt
$containers = @()
function generate-crate($row,$col,$val) {
    $crate = $(New-Object -TypeName PSObject -Property $([ordered]@{
        row = $row
        column = $col
        value = $val
    }))
    #$containers += $crate
    return $crate
}

$row = 1

7..0| ForEach-Object {
    $string = $day5[$_]
    $block1 = $string.Substring(1,1)
    $containers += (generate-crate $row 1 $block1)

    $block2 = $string.Substring(5,1)
    $containers += (generate-crate $row 2 $block2)

    $block3 = $string.Substring(9,1)
    $containers += (generate-crate $row 3 $block3)

    $block4 = $string.Substring(13,1)
    $containers += (generate-crate $row 4 $block4)

    $block5 = $string.Substring(17,1)
    $containers += (generate-crate $row 5 $block5)

    $block6 = $string.Substring(21,1)
    $containers += (generate-crate $row 6 $block6)

    $block7 = $string.Substring(25,1)
    $containers += (generate-crate $row 7 $block7)

    $block8 = $string.Substring(29,1)
    $containers += (generate-crate $row 8 $block8)

    $block9 = $string.Substring(33,1)
    $containers += (generate-crate $row 9 $block9)

    $row++
}

$containers2 = $containers

$day5[10..$day5.count] | ForEach-Object {
    $instruction = $_ -replace '^move ','' -replace 'from','' -replace 'to','' -split '  '
    $moveCount = $instruction[0]
    $moveFrom = $instruction[1]
    $moveTo = $instruction[2]
    1..$moveCount | ForEach-Object {
        $data = $containers | Where-Object {$_.column -eq $moveFrom -and $_.value -ne ' '} | Sort-Object -Property row -Descending
        $dataToMove = $data[0].value
        $data[0].value = ' '

        $newdata = $containers | Where-Object {$_.column -eq $moveTo -and $_.value -ne ' '} | Sort-Object -Property row -Descending
        $newrow = if ($newdata) {$newdata[0].row + 1}else{1}
        $containers += (generate-crate $newrow $moveTo $dataToMove)
    }
}

#part 1 answer
1..9 | ForEach-Object {
    $col = $_
    $containers | Where-Object {$_.column -eq $col -and $_.value -ne ' '} | Sort-Object -Property row -Descending | Select-Object column,value -First 1 
}

$day5[10..$day5.count] | ForEach-Object {
    $instruction = $_ -replace '^move ','' -replace 'from','' -replace 'to','' -split '  '
    $moveCount = $instruction[0]
    $moveFrom = $instruction[1]
    $moveTo = $instruction[2]
    $moveCount..1 | ForEach-Object {
        $pos = $_ - 1
        $data = $containers2 | Where-Object {$_.column -eq $moveFrom -and $_.value -ne ' '} | Sort-Object -Property row -Descending
        $dataToMove = $data[$pos].value
        $data[$pos].value = ' '

        $newdata = $containers2 | Where-Object {$_.column -eq $moveTo -and $_.value -ne ' '} | Sort-Object -Property row -Descending
        $newrow = if ($newdata) {$newdata[0].row + 1}else{1}
        $containers2 += (generate-crate $newrow $moveTo $dataToMove)
    }
}

#part 2 answer
1..9 | ForEach-Object {
    $col = $_
    $containers2 | Where-Object {$_.column -eq $col -and $_.value -ne ' '} | Sort-Object -Property row -Descending | Select-Object column,value -First 1 
}