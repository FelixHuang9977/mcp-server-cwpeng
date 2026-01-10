import json
import os

config = {
  "mcpServers": {
    "aaa": {
      "serverUrl": "http://127.0.0.1:3333/sse"
    },
    "fff-mcp": {
      "serverUrl": "http://127.0.0.1:3333/sse",
      "disabled": True
    },
    "fastcloud": {
      "serverUrl": "https://far-fuchsia-finch.fastmcp.app/mcp",
      "disabled": True
    }
  }
}

path = r"c:\Users\felix\.gemini\antigravity\mcp_config.json"
try:
    with open(path, "w") as f:
        json.dump(config, f, indent=2)
    print("Config file updated: Key 'aaa' set.")
except Exception as e:
    print(f"Config update failed: {e}")
