from fastmcp import FastMCP
from fastapi import FastAPI



mcp = FastMCP("Demo 🚀") # pyright: ignore[reportUnknownVariableType]
mcp_http = mcp.http_app()

app = FastAPI()

@mcp.tool()
def add(a: int, b: int) -> int:
    """Add two numbers"""
    return a + b


app = FastAPI(lifespan=mcp_http.lifespan) #pyright: ignore
app.mount("/mcp-server", mcp_http)


