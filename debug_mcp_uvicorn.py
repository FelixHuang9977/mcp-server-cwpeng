import asyncio
from mcp.client.streamable_http import streamable_http_client
from mcp import ClientSession

async def run():
    url = "http://127.0.0.1:3333/mcp"
    print(f"Connecting to {url}...")
    try:
        async with streamable_http_client(url) as streams:
            print(f"Streams yielded: {len(streams)} items")
            read, write = streams[0], streams[1]
            print("HTTP Transport Connected.")
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
