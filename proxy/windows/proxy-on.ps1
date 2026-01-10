# Force current session output to UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Set console code page
chcp 65001 | Out-Null

# Set proxy
$ProxyAddress = "http://127.0.0.1:7897" 
$env:HTTP_PROXY  = $ProxyAddress
$env:HTTPS_PROXY = $ProxyAddress
$env:NO_PROXY    = "localhost,127.0.0.1,::1,.ctripcorp.com,.ctrip.com,.trip.com,.c-ctrip.com,.tripcdn.com,.tripqate.com,.tripws.com,.baidu.com,.feishu.cn,.larkenterprise.com"

# Check proxy
$ip = curl.exe https://api.ipify.org 2>$null
if ($LASTEXITCODE -eq 0 -and $ip -match '^[0-9.]+$') {
    Write-Host "IP Address: $ip" -ForegroundColor Cyan
    # Get geolocation info
    $geo = curl.exe "http://ip-api.com/json/$ip" 2>$null | ConvertFrom-Json
    Write-Host "Location: $($geo.country) $($geo.regionName) $($geo.city)" -ForegroundColor Cyan
} else {
    Write-Host "Unable to get the outgoing IP, the network may be disconnected or blocked by a firewall." -ForegroundColor Yellow
}
