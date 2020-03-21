$url = $env:AZDO_URL
$token = $env:AZDO_PAT
$pool = $env:AZDO_POOL_NAME
$agentName = $env:AZDO_AGENT_NAME

if ([string]::IsNullOrEmpty($agentName)) { $agentName = $env:COMPUTERNAME }
if ([string]::IsNullOrEmpty($pool)) { $agentName = "Personal-Docker" }

Remove-Item $env:AZDO_PAT -ErrorAction SilentlyContinue

Write-Verbose -Verbose "Configuring agent $agentName for pool $pool"
Write-Verbose -Verbose "Azure URL: $($url)"
Write-Verbose -Verbose "Azure Pool: $($pool)"
Write-Verbose -Verbose "Azure Agent: $($agentName)"
#Write-Verbose -Verbose "PAT: $($token)"

Set-Location c:\agent
Write-Verbose -Verbose "Configuring Agent"
.\config.cmd --unattended --url $url --auth pat --token $token --pool $pool --agent $agentName --acceptTeeEula --replace 

Write-Verbose -Verbose "Running Agent"
.\run.cmd

pause