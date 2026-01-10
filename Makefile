# Makefile for MCP Server
# Works on both Linux and Windows PowerShell

# Detect OS
ifeq ($(OS),Windows_NT)
	PYTHON := python
	VENV_BIN := .venv\Scripts
	VENV_ACTIVATE := .venv\Scripts\Activate.ps1
	RM := powershell -Command "Remove-Item -Recurse -Force"
	MKDIR := powershell -Command "New-Item -ItemType Directory -Force -Path"
else
	PYTHON := python3
	VENV_BIN := .venv/bin
	VENV_ACTIVATE := .venv/bin/activate
	RM := rm -rf
	MKDIR := mkdir -p
endif

.PHONY: help setup start start-http start-https status stop clean

help:
	@echo "MCP Server Makefile Commands:"
	@echo "  make help        - Show this help message"
	@echo "  make setup       - Create virtual environment and install dependencies"
	@echo "  make start       - Start MCP server (alias for start-http)"
	@echo "  make start-http  - Start MCP server in HTTP mode"
	@echo "  make start-https - Start MCP server in HTTPS mode"
	@echo "  make status      - Check if processes are using ports 3333/3334"
	@echo "  make stop        - Stop MCP server (kills processes on ports 3333/3334)"
	@echo "  make clean       - Remove virtual environment"

setup:
	@echo "Creating virtual environment..."
	$(PYTHON) -m venv .venv
	@echo "Installing dependencies..."
ifeq ($(OS),Windows_NT)
	$(VENV_BIN)\pip install -r requirements.txt
else
	$(VENV_BIN)/pip install -r requirements.txt
endif
	@echo "Setup complete!"

start-http:
	@echo "Starting MCP server in HTTP mode..."
ifeq ($(OS),Windows_NT)
	$(VENV_BIN)\fastmcp run app.py --transport sse --port 3333
else
	$(VENV_BIN)/fastmcp run app.py --transport sse --port 3333
endif

start-https:
	@echo "Starting MCP server in HTTPS mode..."
ifeq ($(OS),Windows_NT)
	$(VENV_BIN)\fastmcp run app.py --transport sse --port 3334
else
	$(VENV_BIN)/fastmcp run app.py --transport sse --port 3334
endif

start: start-http

status:
	@echo "Checking MCP server status..."
ifeq ($(OS),Windows_NT)
	@powershell -Command "$$conn = Get-NetTCPConnection -LocalPort 3333,3334 -ErrorAction SilentlyContinue; if ($$conn) { $$conn | ForEach-Object { $$proc = Get-Process -Id $$.OwningProcess -ErrorAction SilentlyContinue; Write-Host \"Port $$($$_.LocalPort): PID $$($$_.OwningProcess) - $$($$proc.ProcessName)\" } } else { Write-Host 'No processes found on ports 3333/3334' }"
else
	@echo "Port 3333:"; lsof -i :3333 2>/dev/null || echo "  No process using port 3333"
	@echo "Port 3334:"; lsof -i :3334 2>/dev/null || echo "  No process using port 3334"
endif

stop:
	@echo "Stopping MCP server..."
ifeq ($(OS),Windows_NT)
	-powershell -Command "$$port = Get-NetTCPConnection -LocalPort 3333 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess; if ($$port) { Stop-Process -Id $$port -Force }"
	-powershell -Command "$$port = Get-NetTCPConnection -LocalPort 3334 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess; if ($$port) { Stop-Process -Id $$port -Force }"
else
	-fuser -k 3333/tcp 2>/dev/null || true
	-fuser -k 3334/tcp 2>/dev/null || true
endif
	@echo "Server stopped."

clean:
	@echo "Removing virtual environment..."
	$(RM) .venv
	@echo "Clean complete!"
