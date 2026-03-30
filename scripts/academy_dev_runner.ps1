param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('help', 'sync', 'import', 'repair', 'admin', 'clear', 'optimize')]
    [string]$Action,

    [Parameter(Mandatory = $true)]
    [string]$Token,

    [string]$BaseUrl = 'https://academy-dev.octopus.be'
)

$runnerUrl = "$BaseUrl/__academy_runner.php?token=$([uri]::EscapeDataString($Token))&action=$([uri]::EscapeDataString($Action))"

Write-Host "Calling: $runnerUrl"

try {
    $response = Invoke-WebRequest -Uri $runnerUrl -Method GET -UseBasicParsing -TimeoutSec 300
    Write-Host "HTTP $($response.StatusCode)"
    Write-Output $response.Content
    exit 0
} catch {
    if ($_.Exception.Response -ne $null) {
        $statusCode = [int]$_.Exception.Response.StatusCode
        Write-Host "HTTP $statusCode"
        try {
            $stream = $_.Exception.Response.GetResponseStream()
            $reader = New-Object System.IO.StreamReader($stream)
            $body = $reader.ReadToEnd()
            if ($body) {
                Write-Output $body
            }
        } catch {
            Write-Host "Kon response body niet lezen."
        }
    } else {
        Write-Error $_
    }
    exit 1
}
