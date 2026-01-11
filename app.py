import time
from fastmcp import FastMCP

mcp = FastMCP("aaa")

@mcp.tool
def add(n1: int, n2: int) -> int:
    """Add Two Numbers"""
    time.sleep(0.05)
    return n1 + n2
