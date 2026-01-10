import asyncio
# import httpx # Not needed directly
from mcp.client.sse import sse_client
from mcp import ClientSession

async def run():
    url = "http://127.0.0.1:3333/sse"
    print(f"Connecting to {url}...")
    try:
        async with sse_client(url) as (read, write):
            print("SSE Connected.")
            async with ClientSession(read, write) as session:
                await session.initialize()
                print("Initialized.")
                tools = await session.list_tools()
                print(f"Tools found: {[t.name for t in tools.tools]}")
                result = await session.call_tool("add", arguments={"n1": 1, "n2": 9})
                print(f"Result: {result}")
    except Exception as e:
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    asyncio.run(run())
