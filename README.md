# MCP Server - Quick Start Guide

This MCP server provides simple tools using FastMCP framework.

## Prerequisites

- Python 3.8 or higher
- Make utility (included in most Linux distributions, available via Git Bash or Chocolatey on Windows)

## Quick Start

### 1. Setup Environment

Create virtual environment and install dependencies:

```bash
make setup
```

### 2. Start Server

**HTTP Mode (recommended for development):**
```bash
make start-http
```
Server will run on `http://0.0.0.0:3333` (SSE endpoint: `/sse`)

**HTTPS Mode:**
```bash
make start-https
```
Server will run on `https://0.0.0.0:3334` (SSE endpoint: `/sse`)

### 3. Stop Server

```bash
make stop
```

### 4. View All Commands

```bash
make help
```

## Available Tools

- **add**: Add two numbers together

## Manual Setup (without Make)

### Windows PowerShell

```powershell
# Create virtual environment
python -m venv .venv

# Activate virtual environment
.\.venv\Scripts\Activate.ps1

# Install dependencies
pip install -r requirements.txt

# Run server (HTTP)
.venv\Scripts\fastmcp run app.py --transport sse --port 3333

# Run server (HTTPS)
.venv\Scripts\fastmcp run app.py --transport sse --port 3334
```

### Linux/macOS

```bash
# Create virtual environment
python3 -m venv .venv

# Activate virtual environment
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Run server (HTTP)
.venv/bin/fastmcp run app.py --transport sse --port 3333

# Run server (HTTPS)
.venv/bin/fastmcp run app.py --transport sse --port 3334
```

## Configuration

The server can be configured in `app.py`. Add new tools by decorating functions with `@app.tool`.

## Troubleshooting

- **Make command not found**: Install Make utility or use manual setup commands
- **Port already in use**: Stop the server with `make stop` or change the port in the Makefile
- **Permission denied**: On Linux/macOS, you may need to run with appropriate permissions

## License

MIT
