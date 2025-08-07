# Copilot MCP Setup Guide

This guide explains how to set up Model Context Protocol (MCP) for GitHub Copilot in VS Code, using the MCP extension or by configuring the `mcp.json` file at the workspace or global scope. Example configurations for Atlassian, GitHub, and Context7 are provided.

---

## 1. Prerequisites

- [VS Code](https://code.visualstudio.com/)
- [GitHub Copilot extension](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)
- [MCP extension](https://marketplace.visualstudio.com/items?itemName=GitHub.mcp) (optional, for advanced context management)

---

## 2. Setting Up MCP in VS Code

### Option 1: Using the MCP Extension

1. Install the required extensions from the VS Code Marketplace:
   - [MCP extension](https://marketplace.visualstudio.com/items?itemName=GitHub.mcp)
   - [GitHub Copilot extension](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)
2. Reload VS Code after installation if prompted.
3. Open the Command Palette (`Ctrl+Shift+P`), search for `MCP: Add Server`.
   - You will see several options for adding an MCP server:
   - **Command (stdio):** Run a local command that implements the MCP protocol. Choose this if you have a local script or binary that acts as an MCP server. You will need to provide the command to run.
   - **HTTP (HTTP or Server-Sent Events):** Connect to a remote HTTP server that implements the MCP protocol. Enter the server URL and any required authentication details.
   - **NPM Package:** Install and run an MCP server from an NPM package. Provide the package name and follow prompts for installation.
   - **Pip Package:** Install and run an MCP server from a Python pip package. Provide the package name and follow prompts for installation.
   - **Docker Image:** Run an MCP server from a Docker image. Enter the image name and any required configuration.
   - **Browse MCP Servers...:** Opens a list of available and trusted MCP servers. You can view, add, or manage servers from this interface. This is the recommended way to manage multiple servers and see their status. To use it:
4. To view or manage available MCP servers, search for and run `MCP: Browse Servers` in the Command Palette. This lets you see, add, or manage trusted servers or visit https://code.visualstudio.com/mcp.
5. install required mcp server extensions (e.g., Atlassian, GitHub, Context7).
6. The extension will manage your `mcp.json` file automatically. and will be list in Extentsion try under the MCP SERVERS - INSTALLED section
7. By the right click you can start MCP Server some of them will open auth window

### Option 2 : Manual Configuration via `mcp.json`

You can manually create or edit an `mcp.json` file in your workspace root for project-specific settings, or in your user settings folder for global scope.

- **Workspace scope:** Place `mcp.json` in your project root.
- **Global scope:** Place `mcp.json` in your VS Code user settings directory (see [VS Code docs](https://code.visualstudio.com/docs/getstarted/keybindings#_keyboard-shortcuts-editor) for location).

---

## 3. Example `mcp.json` Configurations

### Atlassian Example

```json
{
  "servers": {
    "atlassian": {
      "type": "http",
      "url": "https://mcp.atlassian.com/v1/sse",
      "gallery": true
    }
  },
  "inputs": []
}
```

### GitHub Example

```json
{
	"servers": {
		"github": {
			"type": "http",
			"url": "https://api.githubcopilot.com/mcp/",
			"gallery": true
		},
	"inputs": []
}
```

### Context7 Example

```json
{
  "servers": {
    "context7": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"],
      "gallery": true
    }
  },
  "inputs": []
}
```
in case the above example not work.

### Context7 Example 2

```json
{
  "servers": {
    "context7": {
      "command": "docker",
      "timeout": 60000,
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "MCP_TRANSPORT",
        "-e",
        "PORT",
        "mcp/context7"
      ],
      "env": {
        "MCP_TRANSPORT": "stdio",
        "PORT": "8089"
      }
    }
  },
  "inputs": []
}
```

---

## 4. Tips

- You can combine multiple server in a single `mcp.json`.
- After editing `mcp.json`, reload VS Code or use the MCP extension's reload command.
- For sensitive data, prefer using environment variables or VS Code secrets storage if supported.
- Use `>MCP : List Server` command to list avaliable server and start or stop any server.

---

## 5. References

- [MCP Extension Documentation](https://marketplace.visualstudio.com/items?itemName=GitHub.mcp)
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [Atlassian API Docs](https://developer.atlassian.com/)
- [Context7 Docs](https://context7.com/docs)

---

For further help, open an issue or check the extension documentation.
