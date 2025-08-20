### 🔄 Project Awareness & Context

- **Always start by reading the entire PRP file** provided for the current task (e.g., `PRPs/active/123-feature.md`). This file contains the full plan, including the original GitHub issue and all related comments, and is your **single source of truth** for the task at hand.
- **Use the `examples/` directory** to understand the project's architectural patterns and coding style. Your implementation must match these patterns.
- **Use consistent naming conventions, file structure, and architecture patterns** as demonstrated in the codebase and examples.
- **Use venv_linux** (the virtual environment) whenever executing Python commands, including for unit tests.

### 🧱 Code Structure & Modularity

- **Never create a file longer than 500 lines of code.** If a file approaches this limit, refactor by splitting it into modules or helper files.
- **Organize code into clearly separated modules**, grouped by feature or responsibility.
  For agents this looks like:
  - `agent.py` - Main agent definition and execution logic
  - `tools.py` - Tool functions used by the agent
  - `prompts.py` - System prompts
- **Use clear, consistent imports** (prefer relative imports within packages).
- **Use clear, consistent imports** (prefer relative imports within packages).
- **Use python_dotenv and load_env()** for environment variables.

### 🧪 Testing & Reliability

- **Always create Pytest unit tests for new features** (functions, classes, routes, etc).
- **After updating any logic**, check whether existing unit tests need to be updated. If so, do it.
- **Tests should live in a `/tests` folder** mirroring the main app structure.
  - Include at least:
    - 1 test for expected use
    - 1 edge case
    - 1 failure case
- **CRITICAL: All feature implementations must conclude by successfully running the `./validate.sh` script. The task is not complete until this script passes with exit code 0.**

### ✅ Task Completion

- **The PRP file is your task definition.** Work through all acceptance criteria and requirements specified in the PRP.
- **CRITICAL: Do not reference old `PLANNING.md` or `TASK.md` files** for task-specific instructions. The PRP file contains everything you need.

### 📎 Style & Conventions

- **Use Python** as the primary language.
- **Follow PEP8**, use type hints, and format with `black`.
- **Use `pydantic` for data validation**.
- Use `FastAPI` for APIs and `SQLAlchemy` or `SQLModel` for ORM if applicable.
- Write **docstrings for every function** using the Google style:

  ```python
  def example():
      """
      Brief summary.

      Args:
          param1 (type): Description.

      Returns:
          type: Description.
      """
  ```

### 📚 Documentation & Explainability

- **Update `README.md`** when new features are added, dependencies change, or setup steps are modified.
- **Comment non-obvious code** and ensure everything is understandable to a mid-level developer.
- When writing complex logic, **add an inline `# Reason:` comment** explaining the why, not just the what.

### 🧠 AI Behavior Rules

- **Never assume missing context. Ask questions if uncertain.**
- **Never hallucinate libraries or functions** – only use known, verified packages.
- **Always confirm file paths and module names** exist before referencing them in code or tests.
- **Never delete or overwrite existing code** unless explicitly instructed to or if part of the current PRP task.**


## Visual Development

### Design Principles
- Comprehensive design checklist in `/context/design-principles.md`
- Brand style guide in `/context/style-guide.md`
- When making visual (front-end, UI/UX) changes, always refer to these files for guidance

### Quick Visual Check
IMMEDIATELY after implementing any front-end change:
1. **Identify what changed** - Review the modified components/pages
2. **Navigate to affected pages** - Use `mcp__playwright__browser_navigate` to visit each changed view
3. **Verify design compliance** - Compare against `/context/design-principles.md` and `/context/style-guide.md`
4. **Validate feature implementation** - Ensure the change fulfills the user's specific request
5. **Check acceptance criteria** - Review any provided context files or requirements
6. **Capture evidence** - Take full page screenshot at desktop viewport (1440px) of each changed view
7. **Check for errors** - Run `mcp__playwright__browser_console_messages`

This verification ensures changes meet design standards and user requirements.

### Comprehensive Design Review
Invoke the `@agent-design-review` subagent for thorough design validation when:
- Completing significant UI/UX features
- Before finalizing PRs with visual changes
- Needing comprehensive accessibility and responsiveness testing

## 🤖 Using Gemini CLI as a Tool

### When to Use Gemini CLI
Use `gemini` as a **token-efficient analysis agent** for:
- **Large codebase summarization** - Condense findings across multiple files
- **Research synthesis** - Gather and summarize current information from web
- **Analysis reports** - Provide targeted insights rather than full implementations
- **Decision support** - Compare options and recommend approaches
- **Context compression** - Distill complex information into actionable summaries

**Key Principle**: Gemini CLI should **analyze and summarize** rather than generate full code, saving your tokens for the actual implementation work.

### Basic Usage

#### Interactive Mode
```bash
# Start interactive session in current directory
gemini

# Start with specific model
gemini -m gemini-2.0-flash-latest

# Include multiple directories for context
gemini --include-directories ../lib,../docs
```

#### Non-Interactive Mode
```bash
# Direct prompt execution
gemini -p "Explain this codebase architecture"

# Pipe input for automation
echo "What is fine tuning?" | gemini

# Interactive with initial prompt
gemini -i "analyze this code for security issues"
```

### File Context with @ Commands

```bash
# Single file analysis
@src/auth.py Review this authentication module

# Directory analysis
@src/ Analyze all source files for patterns

# Multiple files with spaces (escape paths)
@My\ Documents/config.py Check this configuration
```

**Note**: Uses `read_many_files` tool internally, respects `.gitignore`, excludes binary files automatically.

### Built-in Slash Commands

#### Core Commands
```bash
/help          # Show available commands
/clear         # Clear terminal (Ctrl+L)
/stats         # View token usage and session stats
/quit          # Exit CLI (/exit also works)
/copy          # Copy last output to clipboard
```

#### Memory Management
```bash
/memory add <text>     # Add facts to AI memory
/memory show           # Display current memory content
/memory refresh        # Reload from GEMINI.md files
```

#### Session Management
```bash
/chat save <tag>       # Save conversation state
/chat resume <tag>     # Resume saved conversation
/chat list             # List saved conversations
/chat delete <tag>     # Delete saved conversation
```

#### Tool Configuration  
```bash
/tools                 # List available tools
/tools desc            # Show tool descriptions
/tools nodesc          # Hide descriptions (Ctrl+T toggle)
/mcp schema            # Show MCP tool JSON schemas
```

### Shell Command Execution

#### Direct Shell Access
```bash
# Execute single commands
!ls -la
!git status
!npm test

# Toggle shell mode (type ! alone)
!
# Now in shell mode - all input runs as commands
# Type ! again to exit shell mode
```

**Environment**: All commands run with `GEMINI_CLI=1` environment variable set.

### Advanced Features

#### Sandboxing
```bash
# Enable Docker sandbox for safety
gemini --sandbox -p "analyze and test this code"

# Via environment
export GEMINI_SANDBOX=true
gemini -p "run the test suite"
```

#### Custom Commands (TOML)
Create reusable commands in `~/.gemini/commands/` or `<project>/.gemini/commands/`:

```toml
# ~/.gemini/commands/review.toml
description = "Code security review"
prompt = "Perform a security audit of the provided code, focusing on input validation and authentication."
```

Usage: `/review @src/auth.py`

#### Configuration
```json
// ~/.gemini/settings.json
{
  "autoAccept": true,           // Auto-approve safe tool calls
  "theme": "GitHub",            // UI theme
  "vimMode": true,             // Enable vim keybindings
  "sandbox": "docker",         // Default sandboxing
  "coreTools": ["ReadFileTool", "run_shell_command"],  // Limit available tools
  "excludeTools": ["run_shell_command(rm)"]           // Block dangerous commands
}
```

### Token-Efficient Usage Patterns

#### Analysis & Summarization
```bash
# Codebase overview (not full code generation)
gemini -p "Analyze @src/ and provide a 3-bullet summary of the main architecture patterns"

# Research synthesis
gemini -p "Research FastAPI vs Flask for microservices and give me 5 key decision factors"

# Security audit summary  
gemini -p "Review @src/auth.py @src/models/ and list the top 3 security concerns"

# Performance bottleneck identification
gemini -p "Analyze @src/ for performance issues and rank the top 5 by impact"
```

#### Decision Support
```bash
# Technology comparison
gemini -p "Compare 3 approaches for user authentication in @requirements.txt context. Give pros/cons table"

# Code review insights
gemini -p "Review @src/api/ and suggest 3 specific improvements with reasoning"

# Architecture recommendations
gemini -p "Given @src/ @README.md, recommend the best database choice and explain why"
```

#### Context Compression
```bash
# Meeting prep from codebase
gemini -p "Create talking points for code review meeting based on @src/ changes"

# Documentation gaps
gemini -p "Identify 5 missing documentation areas in @src/ @docs/"

# Onboarding summary
gemini -p "Create new developer onboarding checklist based on @src/ @README.md"
```

**Pattern**: Ask for **specific, bounded outputs** (top 3, 5 key points, brief summary) rather than "implement" or "generate full code".

### Integration Best Practices

#### Project Setup
- Keep project context in `GEMINI.md` files (auto-loaded)
- Use `/init` command to generate project context file
- Set `GEMINI_API_KEY` environment variable for authentication

#### Workflow Integration
- **Pre-implementation research**: Use Gemini CLI to analyze and plan before coding
- **Use `@filename` syntax** for relevant code context in analysis queries
- **Save findings**: Use `/memory add` to store important insights for Claude
- **Compress complex decisions**: Get summaries before detailed implementation
- **Follow up with validation**: After implementing based on Gemini analysis, run `./validate.sh`

#### Security
- Configure `coreTools`/`excludeTools` to limit shell access
- Use confirmation prompts for destructive operations
- Review all generated code before execution
- Enable sandboxing for production environments