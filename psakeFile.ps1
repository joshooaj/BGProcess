properties {
    # Set this to $true to create a module with a monolithic PSM1
    $PSBPreference.Build.CompileModule = $true
    $PSBPreference.Help.DefaultLocale = 'en-US'
    $PSBPreference.Test.OutputFile = 'out/testResults.xml'
}

task Default -depends Test, Docs

task Test -FromModule PowerShellBuild -minimumVersion '0.6.1'

task Docs {
    $docsSrc = Join-Path $psake.build_script_dir 'docs/en-US'
    $docsDst = Join-Path $psake.build_script_dir 'mkdocs/Functions'
    $imgSrc = Join-Path $psake.build_script_dir 'images'
    $imgDst = Join-Path $psake.build_script_dir 'mkdocs/images'
    $indexSrc = Join-Path $psake.build_script_dir 'README.md'
    $indexDst = Join-Path $psake.build_script_dir 'mkdocs/index.md'
    $cachePath = Join-Path $psake.build_script_dir '.cache'
    if (Test-Path $docsDst) {
        Remove-Item $docsDst -Recurse
    }
    Copy-Item -Path $docsSrc -Destination $docsDst -Recurse
    Copy-Item -Path $imgSrc -Destination $imgDst -Recurse -Force
    Copy-Item -Path $indexSrc -Destination $indexDst -Force
}
