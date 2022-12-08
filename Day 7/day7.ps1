$inputFile = Get-Content ./day7.txt

function buildTree($x) {
    $results = @()
    $currentDir = "root"
    $parentDir = ""
    $dirIndex = 0
    [array]$indexedDirs = @()

    foreach ($line in $x) {
        if ($line[0] -eq "$") {
            if ($line.Substring(2,2) -eq "cd") {
                if ($line.Substring(5,1) -eq "/") {
                    $v = $(New-Object -TypeName PSObject -Property $([ordered]@{
                        index = $dirIndex
                        dir = $currentDir 
                    }))
                    $indexedDirs += $v
                }
                elseif ($line.Substring(5,2) -eq "..") {
                    [array]$indexedDirs = $indexedDirs | Where-Object {$_.index -ne $dirIndex}
                    $dirIndex--
                    $currentDir = ($indexedDirs | Where-Object {$_.index -eq $dirIndex}).dir
                    $parentDir = ($indexedDirs | Where-Object {$_.index -eq $dirIndex - 1}).dir
                }
                else {
                    $dirIndex++
                    $parentDir = $currentDir
                    $currentDir = $line.Substring(5,$line.Length - 5)
                    $v = $(New-Object -TypeName PSObject -Property $([ordered]@{
                        index = $dirIndex
                        dir = $currentDir 
                    }))
                    $indexedDirs += $v
                }  
        }
        if ($line.Substring(2,2) -eq "ls") {
            #Write-Host "List files in directory"
        }
        }
        else {
            if ($line.Substring(0,3) -eq "dir") {
               #Write-Host "This is a Directory"
                $w = $(New-Object -TypeName PSObject -Property $([ordered]@{
                    index = $dirIndex
                    parent = $parentDir
                    dir = $currentDir
                    file = $null
                    filesize = $null
                    
                }))
                $results += $w
            }
            else {
                $z = $line.Split(" ")
                $w = $(New-Object -TypeName PSObject -Property $([ordered]@{
                    index = $dirIndex
                    parent = $parentDir
                    dir = $currentDir
                    file = $z[1]
                    filesize = $z[0]
                    
                }))
                $results += $w
            }
        }
    }
    return $results
}

$tree = buildTree $inputFile | Where-Object {$_.index -ne 0}

$tree | Sort-Object {$_.parent} | Format-Table -AutoSize
