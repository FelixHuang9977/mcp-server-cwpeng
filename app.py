import asyncio
from fastmcp import FastMCP

mcp = FastMCP("aaa")

@mcp.tool
async def add(n1: int, n2: int) -> int:
    await asyncio.sleep(0)   # yield event loop
    return n1 + n2