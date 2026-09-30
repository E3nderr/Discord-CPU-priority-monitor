# Monitor and enforce Normal priority for Discord every n seconds
$processName = "Discord"
$targetPriority = "Normal"
$checkInterval = 1  # n in seconds

while ($true) {
    try {
        $processes = Get-Process -Name $processName -ErrorAction SilentlyContinue
        
        if ($processes) {
            foreach ($process in $processes) {
                if ($process.PriorityClass -ne $targetPriority) {
                    $oldPriority = $process.PriorityClass
                    $process.PriorityClass = $targetPriority
                }
            }
        }
    } catch {
        Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Error: $_"
    }
    
    Start-Sleep -Seconds $checkInterval
}