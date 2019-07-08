#requires -Module ModuleBuilder
[CmdletBinding()]
param(
    # A version number to update the output with (uses gitversion by default)
    $Version = $(gitversion -showvariable nugetversion),

    # The output folder (defaults to the workspace root)
    $OutputDirectory = $PSScriptRoot,

    # If set, removes the output folder without prompting!
    [switch]$Force
)

$VersionPrefix, $VersionSuffix = $Version -split '[-+]', 2

dotnet build -c Release -p:VersionPrefix=$VersionPrefix -p:VersionSuffix=$VersionSuffix

Build-Module $PSScriptRoot\Module\PowerShellLogging -OutputDirectory $OutputDirectory -SemVer $Version
