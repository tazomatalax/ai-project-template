# 🧠 AI Project Template

A comprehensive starter template for AI-enhanced development projects with built-in Model Context Protocol (MCP) support for VS Code and other AI coding assistants.

## 📋 Overview

This template provides a standardized project structure optimized for AI-assisted development workflows. It includes:

- Predefined folder structure for data science/ML projects
- MCP server configurations for VS Code integration
- Documentation templates (PLANNING.md, TASK.md)
- Workflow guidance for effective AI collaboration
- Project setup scripts and utilities

## 🚀 Getting Started

### Prerequisites

- [VS Code](https://code.visualstudio.com/) with GitHub Copilot or other AI assistant
- [GitHub CLI](https://cli.github.com/) (optional, for repository management)
- Python 3.8+ (for Python projects)
- Node.js and npm (for MCP servers)
- `curl` or `wget` (for downloading the setup script)

### Quick Start

Create a new project with a single command:

```bash
bash <(curl -s https://raw.githubusercontent.com/username/AI-project-template/main/create-project.sh) <new-project-folder> <repo-url> [branch]
```

Or, if you prefer `wget`:

```bash
bash <(wget -qO- https://raw.githubusercontent.com/username/AI-project-template/main/create-project.sh) <new-project-folder> <repo-url> [branch]
```

Example:

```bash
bash <(curl -s https://raw.githubusercontent.com/tazomatalax/AI-project-template/main/create-project.sh) ~/projects/my-new-project https://github.com/username/AI-project-template.git
```

This will:

1. Download and execute the `create-project.sh` script
2. Clone the template repository into the specified folder
3. Unlink the project from the template repository
4. Open the new project in a new VS Code window

### Detailed Steps

1. Clone this repository or use it as a template:
   ```bash
   git clone https://github.com/username/AI-project-template.git my-new-project
   ```

2. Navigate to your project directory:
   ```bash
   cd my-new-project
   ```

3. Set up the VS Code MCP configuration:
   ```bash
   mv mcp.vscode .vscode
   ```

4. Install required dependencies:
   ```bash
   pip install -r requirements.txt
   ```

5. Initialize your project structure:
   ```bash
   # Update PLANNING.md and TASK.md with your project details
   ```

### Creating a New GitHub Repository

Use the included script to create and set up a new GitHub repository:

```bash
./create-project.sh my-new-project [options]
```

Options:
- `-t, --template <template>`: Template repository to use
- `-p, --private`: Create private repository (default: public)
- `-d, --description "text"`: Repository description

## 📁 Project Structure

```
project-root/
├── .vscode/              # VS Code configuration including MCP settings
├── data/                 # Data directories for various stages of processing
│   ├── external/         # Data from external sources
│   ├── interim/          # Intermediate processed data
│   ├── processed/        # Final processed data for modeling
│   └── raw/              # Original immutable data
├── references/           # Data dictionaries, manuals, and explanatory materials
├── reports/              # Generated analysis reports and figures
│   └── figures/          # Generated graphics and figures
├── src/                  # Source code for use in this project
│   ├── __init__.py       # Makes src a Python module
│   └── services/         # Service modules and API integrations
├── tests/                # Unit tests and test cases
├── AI_WORKFLOW.md        # Guide for working with AI coding assistants
├── PLANNING.md           # Project planning, architecture, and constraints
├── README.md             # Project overview and setup instructions
├── requirements.txt      # Project dependencies
└── TASK.md               # Task tracking and management
```

## 🔧 MCP Configuration

The template includes pre-configured MCP (Model Context Protocol) servers for enhanced AI assistance:

- **Context7**: Documentation and library reference
- **Git**: Git operations without leaving your AI conversation
- **Brave Search**: Web search capabilities for your AI assistant
- **Filesystem**: File system operations for your AI assistant

### Setting up MCP

1. Ensure the `.vscode` directory contains the MCP configuration
2. Install required npm packages:
   ```bash
   npm install -g uvx @upstash/context7-mcp @modelcontextprotocol/server-brave-search @modelcontextprotocol/server-filesystem
   ```
3. Configure any required API keys when prompted

## 📊 AI Workflow Integration

This template is designed to optimize AI-assisted development workflows with multi-agent collaboration:

### Dual-Agent Approach
The template includes configuration for both **Claude** and **Gemini CLI** working together efficiently:

**Example Workflow:**
1. **Analysis Phase** (Gemini CLI):
   ```bash
   # Gemini analyzes and summarizes
   gemini -p "Analyze @src/ for security vulnerabilities and rank top 3 issues"
   ```
   
2. **Implementation Phase** (Claude):
   ```
   User shares Gemini's summary: "Found: 1) Missing rate limiting, 2) JWT expiration, 3) SQL injection risk"
   Claude implements specific fixes based on the analysis
   ```

### Agent Instructions
- **CLAUDE.md**: Instructions for Claude on leveraging Gemini CLI for analysis
- **GEMINI.md**: Instructions for Gemini on providing token-efficient summaries
- **AI_WORKFLOW.md**: General AI collaboration guidelines

### Setup Steps
1. Start by filling out `PLANNING.md` with project details
2. Create initial task list in `TASK.md`
3. Configure AI agents using their respective `.md` files
4. Leverage MCP for enhanced AI capabilities
5. Use Gemini CLI for large-scale analysis, Claude for focused implementation

This approach **maximizes token efficiency** by having Gemini handle analysis/research and Claude handle implementation.

## 🛠️ Customization

### Adding Additional MCP Servers

1. Edit the `.vscode/mcp.json` file to add new server configurations:
   ```json
   "your-server-name": {
     "command": "command-to-run",
     "args": ["arg1", "arg2"]
   }
   ```

2. Update `AI_WORKFLOW.md` to document the new capability

### Project Structure Customization

Modify the folder structure based on your project needs:

- For web applications: Add `frontend/` and `backend/` directories
- For ML projects: Consider adding `models/` and `notebooks/` directories
- For APIs: Add `api/` and `docs/` directories

## 📝 Best Practices

- Always update `PLANNING.md` when architectural decisions change
- Keep `TASK.md` current with ongoing and completed work
- Use consistent coding standards as defined in your AI global rules
- Write tests for all new functionality
- Document as you go, don't delay documentation

## 📚 Additional Resources

- [Model Context Protocol Documentation](https://modelcontextprotocol.ai/)
- [VS Code AI Extensions](https://marketplace.visualstudio.com/search?term=ai&target=VSCode)
- [Python Data Science Handbook](https://jakevdp.github.io/PythonDataScienceHandbook/)
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.