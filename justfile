set shell := ['PowerShell', '-NoProfile', '-c']
dir := justfile_directory()
dir_bin := dir + '\bin'
dir_cache := dir + '\cache'
dir_release := dir + '\target\release'
default: export
export:
    cargo build -r
    [Environment]::SetEnvironmentVariable('OCTOBUILD_CACHE', '{{dir_cache}}', 'User')
    if (!(Test-Path '{{dir_bin}}')) { New-Item -ItemType Directory -Force -Path '{{dir_bin}}' | Out-Null }
    $p = [Environment]::GetEnvironmentVariable('Path', 'User'); if (($p -split ';') -notcontains '{{dir_bin}}') { [Environment]::SetEnvironmentVariable('Path', ($p + ';' + '{{dir_bin}}').Trim(';'), 'User') }
    Copy-Item -Path '{{dir_release}}\octo_agent.exe' -Destination '{{dir_bin}}\octo_agent.exe' -Force
    Copy-Item -Path '{{dir_release}}\xgConsole.exe' -Destination '{{dir_bin}}\xgConsole.exe' -Force