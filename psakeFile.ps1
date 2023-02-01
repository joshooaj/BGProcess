properties {
    # Set this to $true to create a module with a monolithic PSM1
    $PSBPreference.Build.CompileModule = $true
    $PSBPreference.Help.DefaultLocale = 'en-US'
    $PSBPreference.Test.OutputFile = 'out/testResults.xml'
    $PSBPreference.Publish.PSRepository = "PSGallery"
    $PSBPreference.Publish.PSRepositoryApiKey = $env:PSGALLERY_API_KEY

}

task Default -depends Test

task Test -FromModule PowerShellBuild -minimumVersion '0.6.1'

task Publish -FromModule PowerShellBuild -minimumVersion '0.6.1'

task DeployDocs -depends StageDocs {
    switch ($env:BHBuildSystem) {
        'Unknown' {
            $env:GHCR_TOKEN | docker login -u joshooaj --password-stdin ghcr.io
            docker pull ghcr.io/joshooaj/mkdocs-material-insiders:latest
            docker run --rm -v "$($psake.build_script_dir)`:/docs" -u 1000:1000 ghcr.io/joshooaj/mkdocs-material-insiders:latest gh-deploy --force
        }
        default {
            exec {
                & mkdocs gh-deploy --force
            }
        }
    }
}

task StageDocs -depends Test {
    $docsSrc = Join-Path $psake.build_script_dir 'docs/en-US'
    $docsDst = Join-Path $psake.build_script_dir 'mkdocs/Functions'
    $imgSrc = Join-Path $psake.build_script_dir 'images'
    $imgDst = Join-Path $psake.build_script_dir 'mkdocs/images'
    $indexSrc = Join-Path $psake.build_script_dir 'README.md'
    $indexDst = Join-Path $psake.build_script_dir 'mkdocs/index.md'
    $changelogSrc

    if (Test-Path $docsDst) {
        Remove-Item $docsDst -Recurse
    }
    Copy-Item -Path $docsSrc -Destination $docsDst -Recurse
    Copy-Item -Path $imgSrc -Destination $imgDst -Recurse -Force
    Copy-Item -Path $indexSrc -Destination $indexDst -Force
}
