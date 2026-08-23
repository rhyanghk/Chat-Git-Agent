[CmdletBinding()]
param(
    [ValidateSet('codex', 'claude-code', 'cursor', 'copilot', 'gemini')]
    [string]$Platform,
    [string]$Target
)

if (($null -ne $Platform -and $Platform -ne '') -and ($null -ne $Target -and $Target -ne '')) {
    Write-Error 'INSTALL_BLOCKED: choose -Platform or -Target, not both.'
    exit 2
}

if (($null -eq $Platform -or $Platform -eq '') -and ($null -eq $Target -or $Target -eq '')) {
    Write-Error 'Usage: install-agent-executor.ps1 -Platform <codex|claude-code|cursor|copilot|gemini> OR -Target <skill-root>'
    exit 2
}

if ($null -eq $Target -or $Target -eq '') {
    switch ($Platform) {
        'codex' { $Target = Join-Path $HOME '.agents/skills' }
        'cursor' { $Target = Join-Path $HOME '.agents/skills' }
        'copilot' { $Target = Join-Path $HOME '.agents/skills' }
        'gemini' { $Target = Join-Path $HOME '.agents/skills' }
        'claude-code' { $Target = Join-Path $HOME '.claude/skills' }
    }
}

$source = Join-Path (Split-Path -Parent $PSScriptRoot) 'agent-executor'
$destination = Join-Path $Target 'agent-executor'

if (Test-Path -LiteralPath $destination) {
    Write-Error "INSTALL_BLOCKED: destination already exists: $destination"
    Write-Error 'No files were replaced, removed, backed up, or mirrored.'
    exit 3
}

if (-not (Test-Path -LiteralPath $Target)) {
    New-Item -ItemType Directory -Path $Target -ErrorAction Stop | Out-Null
}
Copy-Item -LiteralPath $source -Destination $destination -Recurse -ErrorAction Stop
Write-Output "INSTALLED: $destination"
Write-Output 'Next: start a new Agent execution session and provide an exact numbered task contract.'
