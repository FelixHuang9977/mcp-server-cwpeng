from fastmcp import FastMCP

mcp = FastMCP("aaa")

@mcp.tool
def add(n1: int, n2: int) -> int:
    """Add Two Numbers"""
    return n1 + n2
