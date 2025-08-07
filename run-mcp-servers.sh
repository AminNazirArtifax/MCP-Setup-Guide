#!/bin/bash

# MCP Server Docker Commands
# Replace placeholder values with your actual credentials before running

# Atlassian MCP Server (Jira/Confluence)
run_atlassian() {
    docker run -i --rm \
        -e CONFLUENCE_URL="https://<your-domain>.atlassian.net/wiki" \
        -e CONFLUENCE_USERNAME="<your-email>" \
        -e CONFLUENCE_API_TOKEN="<your-confluence-token>" \
        -e JIRA_URL="https://<your-domain>.atlassian.net" \
        -e JIRA_USERNAME="<your-email>" \
        -e JIRA_API_TOKEN="<your-jira-token>" \
        ghcr.io/sooperset/mcp-atlassian:latest
}

# Context7 MCP Server
run_context7() {
    docker run -i --rm \
        -e MCP_TRANSPORT="stdio" \
        -e PORT="8089" \
        mcp/context7
}

# GitHub MCP Server
run_github() {
    docker run -i --rm \
        -e GITHUB_PERSONAL_ACCESS_TOKEN="<your-github-token>" \
        ghcr.io/github/github-mcp-server
}

# Usage examples:
# ./run-mcp-servers.sh atlassian
# ./run-mcp-servers.sh context7
# ./run-mcp-servers.sh github

case "$1" in
    atlassian)
        echo "Starting Atlassian MCP Server..."
        run_atlassian
        ;;
    context7)
        echo "Starting Context7 MCP Server..."
        run_context7
        ;;
    github)
        echo "Starting GitHub MCP Server..."
        run_github
        ;;
    *)
        echo "Usage: $0 {atlassian|context7|github}"
        echo ""
        echo "Individual commands:"
        echo "# Atlassian MCP Server"
        echo "docker run -i --rm -e CONFLUENCE_URL=\"https://<your-domain>.atlassian.net/wiki\" -e CONFLUENCE_USERNAME=\"<your-email>\" -e CONFLUENCE_API_TOKEN=\"<your-confluence-token>\" -e JIRA_URL=\"https://<your-domain>.atlassian.net\" -e JIRA_USERNAME=\"<your-email>\" -e JIRA_API_TOKEN=\"<your-jira-token>\" ghcr.io/sooperset/mcp-atlassian:latest"
        echo ""
        echo "# Context7 MCP Server"
        echo "docker run -i --rm -e MCP_TRANSPORT=\"stdio\" -e PORT=\"8089\" mcp/context7"
        echo ""
        echo "# GitHub MCP Server"
        echo "docker run -i --rm -e GITHUB_PERSONAL_ACCESS_TOKEN=\"<your-github-token>\" ghcr.io/github/github-mcp-server"
        ;;
esac