# Amazon Q MCP Server Setup Guide

## Overview
This guide explains how to configure Model Context Protocol (MCP) servers in Amazon Q using two configuration files.

## Configuration Files

### 1. `C:\Users\<username>\.aws\amazonq\mcp.json`
- **Purpose**: Global MCP server configurations
- **Scope**: Available across all Amazon Q sessions
- **Contains**: Basic MCP server definitions with commands and environment variables

### 2. `C:\Users\<username>\.aws\amazonq\agents\default.json`
- **Purpose**: Agent-specific configuration with enhanced settings
- **Scope**: Specific to the default agent
- **Contains**: MCP servers + tools configuration, permissions, and advanced settings

## Prerequisites
- Docker Desktop installed and running
- Valid API tokens for the services you want to integrate

## MCP Server Configuration Structure

All MCP servers must be defined under the `mcpServers` key in both configuration files. Here's the basic structure:

```json
{
  "mcpServers": {
    "server-name-1": {
      "command": "docker",
      "args": [...],
      "env": {...}
    },
    "server-name-2": {
      "command": "docker",
      "args": [...],
      "env": {...}
    }
  }
}
```

## Supported MCP Servers

### 1. Atlassian (Jira/Confluence)
```json
"mcp-atlassian": {
  "command": "docker",
  "args": [
    "run", "-i", "--rm",
    "-e", "CONFLUENCE_URL",
    "-e", "CONFLUENCE_USERNAME", 
    "-e", "CONFLUENCE_API_TOKEN",
    "-e", "JIRA_URL",
    "-e", "JIRA_USERNAME",
    "-e", "JIRA_API_TOKEN",
    "ghcr.io/sooperset/mcp-atlassian:latest"
  ],
  "env": {
    "CONFLUENCE_URL": "https://<your-domain>.atlassian.net/wiki",
    "CONFLUENCE_USERNAME": "<your-email>",
    "CONFLUENCE_API_TOKEN": "<your-confluence-token>",
    "JIRA_URL": "https://<your-domain>.atlassian.net",
    "JIRA_USERNAME": "<your-email>",
    "JIRA_API_TOKEN": "<your-jira-token>"
  }
}
```

### 2. Context7
```json
"context7": {
  "command": "docker",
  "timeout": 60000,
  "args": [
    "run", "-i", "--rm",
    "-e", "MCP_TRANSPORT",
    "-e", "PORT",
    "mcp/context7"
  ],
  "env": {
    "MCP_TRANSPORT": "stdio",
    "PORT": "8089"
  }
}
```

### 3. GitHub
```json
"github": {
  "command": "docker",
  "args": [
    "run", "-i", "--rm",
    "-e", "GITHUB_PERSONAL_ACCESS_TOKEN",
    "ghcr.io/github/github-mcp-server"
  ],
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": "<your-github-token>"
  }
}
```

## Getting API Keys and Tokens

### Atlassian API Token
1. Go to [Atlassian Account Settings](https://id.atlassian.com/manage-profile/security/api-tokens)
2. Click "Create API token"
3. Enter a label and click "Create"
4. Copy the generated token

### GitHub Personal Access Token
1. Go to GitHub Settings > Developer settings > Personal access tokens
2. Click "Generate new token (classic)"
3. Select required scopes (repo, read:org, etc.)
4. Click "Generate token"
5. Copy the generated token

## Setup Instructions

1. **Install Docker Desktop** and ensure it's running

2. **Create/Edit mcp.json**:
   ```bash
   # Create the directory if it doesn't exist
   mkdir -p C:\Users\<username>\.aws\amazonq
   
   # Edit the file
   notepad C:\Users\<username>\.aws\amazonq\mcp.json
   ```

3. **Create/Edit default.json**:
   ```bash
   # Create the directory if it doesn't exist
   mkdir -p C:\Users\<username>\.aws\amazonq\agents
   
   # Edit the file
   notepad C:\Users\<username>\.aws\amazonq\agents\default.json
   ```

4. **Replace placeholders** with your actual values:
   - `<username>`: Your Windows username
   - `<your-domain>`: Your Atlassian domain
   - `<your-email>`: Your email address
   - `<your-confluence-token>`: Your Confluence API token
   - `<your-jira-token>`: Your Jira API token
   - `<your-github-token>`: Your GitHub personal access token


5. **Restart Amazon Q** to load the new configurations

## Key Differences Between Files

| Feature | mcp.json | default.json |
|---------|----------|--------------|
| **Scope** | Global MCP servers | Agent-specific configuration |
| **Content** | Server definitions only | Servers + tools + permissions |
| **Tools Array** | Not included | Lists available tools |
| **Permissions** | Not specified | Defines allowed tools and settings |
| **Complexity** | Simple server config | Complete agent configuration |

## Troubleshooting

- Ensure Docker is running before starting Amazon Q
- Verify API tokens are valid and have required permissions
- Check that all placeholder values are replaced with actual credentials
- Restart Amazon Q after configuration changes