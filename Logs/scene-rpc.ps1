param([string]$Method,[string]$Params='{}')
$h=@{Accept='application/json, text/event-stream';'Mcp-Session-Id'=(Get-Content "$PSScriptRoot/scene-fix-session.txt" -Raw).Trim()}
$b=@{jsonrpc='2.0';id=2;method=$Method;params=($Params|ConvertFrom-Json)}|ConvertTo-Json -Depth 50 -Compress
$r=Invoke-WebRequest 'http://127.0.0.1:8080/mcp' -Method Post -ContentType 'application/json' -Headers $h -Body $b -TimeoutSec 60
foreach($l in ($r.Content -split "`n")){if($l.StartsWith('data: ')){$l.Substring(6)}}
