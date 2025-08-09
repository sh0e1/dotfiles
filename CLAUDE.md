# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that manages shell configurations, development tools, and system preferences through symbolic linking. The repository follows a structured approach to organizing configurations across different XDG directories.

## Installation and Setup Commands

```bash
# Install all dotfiles by creating symbolic links
./install.sh

# Install Homebrew and all packages from Brewfile
./scripts/brew.sh

# Install specific package groups
brew bundle --file=Brewfile
```

## Directory Structure and Architecture

### Core Structure
- **Root dotfiles** (`.zshrc`, `.zshenv`, `.editorconfig`) - Shell and editor configurations
- **`.config/`** - XDG Base Directory compliant configurations for tools like tmux, git, tig, etc.
- **`.claude/`** - Claude Code specific configurations including hooks, commands, and agents
- **`scripts/`** - Installation and setup scripts
- **`Brewfile`** - Homebrew package definitions

### Key Configuration Areas

#### Shell Environment (`.zshrc`)
- Uses `zinit` as the plugin manager
- Integrates with `fzf` for fuzzy finding
- Includes `enhancd` for enhanced directory navigation
- Git integration with prompt customization
- Custom functions for tmux session/window management
- GitHub CLI integration with fuzzy finding

#### Terminal Multiplexer (`.config/tmux/`)
- Vi-mode key bindings
- Custom status bar with GCP and Kubernetes context
- Plugin management via TPM (Tmux Plugin Manager)
- Automatic plugin installation on first run

#### Development Tools Integration
- **Git**: Custom commit message templates, ignore patterns
- **Neovim**: Set as default editor via aliases
- **FZF**: Extensively configured for file/command/history search
- **Direnv**: Environment management per directory

#### Claude Code Agents (`.claude/agents/`)
Custom agents extend Claude Code's capabilities with specialized behaviors:
- **branch-code-reviewer**: Performs comprehensive code reviews of git branch changes
  - Compares current branch against base branch (default: origin/main)
  - Reviews committed changes for code quality, security, and best practices
  - Outputs structured review in Japanese with severity classifications
  - Triggered by `/review-current-branch` command or manual agent invocation

## Common Development Workflows

### Dotfiles Management
```bash
# After modifying any dotfile, re-run installation to update symlinks
./install.sh

# The installation script handles three key areas:
# 1. Root dotfiles (excludes .git, .DS_Store, .gitignore, .config, .claude)
# 2. XDG config directory contents (.config/*)
# 3. Claude Code configurations (.claude/*)
```

### Shell and Tool Updates
```bash
# Update Homebrew packages
brew update && brew upgrade

# Update tmux plugins
# Press prefix + U in tmux session
```

### Working with Git
- Commit messages follow specific formatting rules (defined in global Claude instructions)
- Custom git configuration includes delta for better diffs
- GitHub CLI integration provides fuzzy-searchable issue/PR management

## Tool-Specific Commands

### Tmux Session Management
```bash
tmls    # List and switch between tmux sessions using fzf
tmlw    # List and switch between tmux windows using fzf
```

### GitHub Integration
```bash
ghi     # Browse and open GitHub issues with fzf
ghp     # Browse GitHub PRs with fzf (ctrl-o to checkout)
```

### Shell Navigation
- `enhancd` provides enhanced `cd` with fuzzy finding of previous directories
- `fzf` integration for command history (Ctrl+R), files (Ctrl+T), and directories (Alt+C)

## Architecture Notes

### Symbolic Link Management
The install script creates symbolic links from the repository to the home directory, allowing version control of configurations while maintaining expected file locations. Special handling exists for:
- XDG config directory structure
- Claude Code configurations
- Exclusion of repository metadata

### Plugin Ecosystem
- **Zsh**: Managed by zinit with lazy loading for performance
- **Tmux**: Managed by TPM with automatic installation
- **Development tools**: Configured via Homebrew with consistent CLI experience

### Environment Integration
- Supports multiple development environments (Go, Node.js via nvm, Python via pyenv, Ruby via rbenv)
- GNU tools preferred over BSD variants on macOS
- XDG Base Directory specification compliance where possible