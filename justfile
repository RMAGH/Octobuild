set shell := ["powershell.exe", "-NoProfile", "-c"]
default: export
export:
    cargo build -r
    [Environment]::SetEnvironmentVariable("OCTOBUILD_CACHE", "$PWD\cache", "User")
    if (!(Test-Path "bin")) { New-Item -ItemType Directory -Force -Path "bin" | Out-Null }
    Copy-Item -Path "target\release\octo_agent.exe" -Destination "bin\octo_agent.exe" -Force
    Copy-Item -Path "target\release\xgConsole.exe" -Destination "bin\xgConsole.exe" -Force