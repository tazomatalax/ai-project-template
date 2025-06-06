param(
    [Parameter(Position=0, Mandatory=$false)]
    [string]$RepoUrl,
    
    [Parameter(Position=1, Mandatory=$false)]
    [string]$Branch = "main"
)

# Function to display usage with proper script name handling
function Show-Usage {
    # Get just the script name without the full path for display
    $scriptName = Split-Path -Leaf $MyInvocation.ScriptName
    
    Write-Host "Usage: .\$scriptName <repo-url> [branch]"
    Write-Host ""
    Write-Host "Example:"
    Write-Host "  .\$scriptName https://github.com/tazomatalax/ai-project-template.git"
    Write-Host ""
    Write-Host "You will be prompted for the project name and location."
}

# Check if repo URL is provided
if ([string]::IsNullOrEmpty($RepoUrl)) {
    Show-Usage
    exit 1
}

# Get project name from user
$ProjectName = Read-Host -Prompt "Enter project name"
if ([string]::IsNullOrEmpty($ProjectName)) {
    Write-Host "Project name cannot be empty." -ForegroundColor Red
    exit 1
}

# Get project location from user (default is current directory)
$CurrentDirectory = (Get-Location).Path
$ProjectLocation = Read-Host -Prompt "Enter project location (press Enter for current directory: $CurrentDirectory)"
if ([string]::IsNullOrEmpty($ProjectLocation)) {
    $ProjectLocation = $CurrentDirectory
}

# Process the path to ensure it's valid
try {
    $ProjectLocation = [System.IO.Path]::GetFullPath($ProjectLocation)
} catch {
    Write-Host "Invalid path format. Please provide a valid path." -ForegroundColor Red
    exit 1
}

# Combine location and name to form full project path
$ProjectFolder = Join-Path -Path $ProjectLocation -ChildPath $ProjectName

# Inform about pulling files from repo branch
Write-Host "Creating a new project '$ProjectName' in '$ProjectFolder' by pulling template files from branch '$Branch' of repo: $RepoUrl"

# Clone the repository
try {
    # Use quotes to handle paths with spaces properly
    git clone --single-branch --branch $Branch $RepoUrl "$ProjectFolder"
    
    if ($LASTEXITCODE -eq 0) {
        # Unlink the project from the template repository
        if (Test-Path -Path "$ProjectFolder\.git") {
            Remove-Item -Path "$ProjectFolder\.git" -Recurse -Force
        }
        
        # Rename mcp.vscode directory to .vscode if it exists
        if (Test-Path -Path "$ProjectFolder\mcp.vscode") {
            Move-Item -Path "$ProjectFolder\mcp.vscode" -Destination "$ProjectFolder\.vscode"
            Write-Host "Renamed mcp.vscode to .vscode"
        } else {
            Write-Host "Note: mcp.vscode directory not found in template"
        }
        
        Write-Host "Project created successfully in '$ProjectFolder' and unlinked from template repo!"
        Write-Host "Opening '$ProjectFolder' in a new VS Code window..."
        
        # Open VS Code in the project folder
        Start-Process -FilePath "code" -ArgumentList "`"$ProjectFolder`"", "-n"
    } else {
        Write-Host "Failed to create the project." -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
    exit 1
}
