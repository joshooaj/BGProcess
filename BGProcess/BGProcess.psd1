@{
    RootModule = 'BGProcess.psm1'
    ModuleVersion = '0.1.1'
    GUID = '2a5b22c3-25ac-4312-82d3-5a109a235d16'
    Author = 'Joshua Hendricks'
    CompanyName = 'Joshua Hendricks'
    Copyright = '(c) 2023 Joshua Hendricks. All rights reserved.'
    Description = 'Interact with a running process using standard input/output.'
    FunctionsToExport = '*'
    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @()
    PrivateData = @{
        PSData = @{
            Tags = @('Process', 'STDIO', 'StandardOutput', 'StandardError', 'async', 'runspaces')
            LicenseUri = 'https://github.com/joshooaj/BGProcess/blob/main/LICENSE'
            ProjectUri = 'https://github.com/joshooaj/BGProcess'
            IconUri    = 'https://www.joshooaj.com/BGProcess/images/joshooaj.png'
            ReleaseNotes = 'See the GitHub repository at https://github.com/joshooaj/BGProcess.'
        }
    }
}
