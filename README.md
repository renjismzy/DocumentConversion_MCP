# MCP Streamable HTTP Project

[![CI/CD Pipeline](https://github.com/your-org/mcp-streamable-http/workflows/CI/CD%20Pipeline/badge.svg)](https://github.com/your-org/mcp-streamable-http/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![Node.js 18+](https://img.shields.io/badge/node.js-18+-green.svg)](https://nodejs.org/)

A comprehensive implementation of MCP (Model Context Protocol) servers with **Streamable HTTP** and **Stdio** transport support, featuring document conversion capabilities in both Python and TypeScript.

## 📋 Table of Contents

- [Features](#-features)
- [Architecture](#-architecture)
- [Quick Start](#-quick-start)
- [Installation](#-installation)
- [Usage](#-usage)
- [API Documentation](#-api-documentation)
- [Docker Support](#-docker-support)
- [Development](#-development)
- [Testing](#-testing)
- [Contributing](#-contributing)
- [License](#-license)

## ✨ Features

### 🚀 Transport Protocols
- **Streamable HTTP**: Full HTTP-based transport with Server-Sent Events (SSE)
- **Stdio**: Standard input/output transport for direct process communication
- **Cross-language compatibility**: Python clients can communicate with TypeScript servers and vice versa

### 📄 Document Conversion
- **Multiple format support**: PDF, Word (DOCX), Markdown, HTML, RTF, Plain Text
- **Batch processing**: Convert multiple documents simultaneously
- **Format detection**: Automatic input format detection
- **Extensible architecture**: Easy to add new conversion formats

### 🛠 Development Tools
- **Docker support**: Complete containerization with Docker Compose
- **VS Code integration**: Pre-configured debugging and tasks
- **CI/CD pipeline**: GitHub Actions for automated testing and deployment
- **Code quality**: Linting, formatting, and security scanning

## 🏗 Architecture

```
mcp-streamable-http/
├── document-converter/          # Main document conversion servers
│   ├── server/                 # Python implementation
│   │   ├── document_converter.py    # HTTP server
│   │   ├── stdio_server.py          # Stdio server
│   │   └── pyproject.toml           # Python dependencies
│   └── typescript-server/      # TypeScript implementation
│       ├── src/
│       │   ├── index.ts             # HTTP server
│       │   ├── stdio-server.ts      # Stdio server
│       │   └── document-converter.ts # Core logic
│       └── package.json             # Node.js dependencies
├── python-example/             # Example Python client/server
├── typescript-example/         # Example TypeScript client/server
├── docker-compose.yml          # Multi-service orchestration
├── Makefile                    # Build automation
└── .github/workflows/          # CI/CD configuration
```

## 🚀 Quick Start

### Prerequisites

- **Python 3.8+** with pip
- **Node.js 18+** with npm
- **Docker** (optional, for containerized deployment)
- **Make** (optional, for build automation)

### 1. Clone the Repository

```bash
git clone https://github.com/your-org/mcp-streamable-http.git
cd mcp-streamable-http
```

### 2. Quick Setup (All Dependencies)

```bash
# Install all dependencies
npm run install:all

# Build all projects
npm run build:all
```

### 3. Start Document Conversion Servers

#### Python HTTP Server
```bash
npm run start:python-http
# Server available at: http://localhost:3000
```

#### TypeScript HTTP Server
```bash
npm run start:typescript-http
# Server available at: http://localhost:3001
```

#### Stdio Servers
```bash
# Python Stdio
npm run start:python-stdio

# TypeScript Stdio
npm run start:typescript-stdio
```

## 📦 Installation

### Individual Component Installation

#### Python Document Converter
```bash
cd document-converter/server
pip install -e .
```

#### TypeScript Document Converter
```bash
cd document-converter/typescript-server
npm install
npm run build
```

#### Example Projects
```bash
# Python examples
cd python-example/client && pip install -e .

# TypeScript examples
cd typescript-example/client && npm install
cd ../server && npm install
```

## 🎯 Usage

### HTTP API Endpoints

Both Python and TypeScript servers expose the same REST API:

#### Health Check
```bash
GET /health
```

#### MCP Protocol Endpoint
```bash
POST /mcp
Content-Type: application/json

{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/list"
}
```

#### Document Conversion
```bash
POST /mcp
Content-Type: application/json

{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/call",
  "params": {
    "name": "convert-document",
    "arguments": {
      "content": "# Hello World\nThis is a markdown document.",
      "input_format": "md",
      "output_format": "html"
    }
  }
}
```

### Supported Formats

| Format | Input | Output | Description |
|--------|-------|--------|--------------|
| `txt`  | ✅    | ✅     | Plain text |
| `md`   | ✅    | ✅     | Markdown |
| `html` | ✅    | ✅     | HTML |
| `pdf`  | ✅    | ✅     | PDF documents |
| `docx` | ✅    | ✅     | Microsoft Word |
| `rtf`  | ✅    | ✅     | Rich Text Format |

### Environment Configuration

Copy `.env.example` to `.env` and configure:

```bash
cp .env.example .env
```

Key configuration options:
- `PYTHON_SERVER_PORT=3000`
- `TYPESCRIPT_SERVER_PORT=3001`
- `DEBUG=true`
- `LOG_LEVEL=info`

## 🐳 Docker Support

### Build and Run with Docker Compose

```bash
# Build all images
docker-compose build

# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop all services
docker-compose down
```

### Individual Service Management

```bash
# Start only Python server
docker-compose up python-http-server

# Start only TypeScript server
docker-compose up typescript-http-server

# Start with load balancer
docker-compose --profile load-balancer up
```

## 🛠 Development

### Using Make Commands

```bash
# Show all available commands
make help

# Install dependencies
make install

# Build projects
make build

# Run tests
make test

# Start development servers
make dev-python-http
make dev-ts-http

# Clean build artifacts
make clean
```

### VS Code Integration

This project includes comprehensive VS Code configuration:

- **Debugging**: Pre-configured launch configurations for all servers
- **Tasks**: Build, test, and run tasks
- **Extensions**: Recommended extensions for Python and TypeScript development
- **Settings**: Optimized workspace settings

### Code Quality

```bash
# Format code
make format

# Lint code
make lint

# Run security scan
make security-scan
```

## 🧪 Testing

### Run All Tests

```bash
npm run test
# or
make test
```

### Individual Test Suites

```bash
# Python tests
cd document-converter/server && python -m pytest

# TypeScript tests
cd document-converter/typescript-server && npm test
```

### Health Checks

```bash
# Check server health
make health-check

# Manual health check
curl http://localhost:3000/health
curl http://localhost:3001/health
```

## 📚 API Documentation

### Available Tools

#### `convert-document`
Convert a document from one format to another.

**Parameters:**
- `content` (string): Document content
- `input_format` (string): Source format (txt, md, html, pdf, docx, rtf)
- `output_format` (string): Target format
- `filename` (string, optional): Original filename for context

#### `list-supported-formats`
Get list of all supported input and output formats.

#### `convert-file-batch`
Convert multiple files to the same output format.

**Parameters:**
- `files` (array): List of files with content and input_format
- `output_format` (string): Target format for all files

### Transport Protocols

#### Streamable HTTP
- **Endpoint**: `POST /mcp`
- **Content-Type**: `application/json`
- **Protocol**: JSON-RPC 2.0
- **Streaming**: Server-Sent Events support

#### Stdio
- **Protocol**: JSON-RPC 2.0 over stdin/stdout
- **Usage**: Direct process communication
- **Ideal for**: CLI tools and process integration

## 🤝 Contributing

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Make your changes** and add tests
4. **Run the test suite**: `make test`
5. **Commit your changes**: `git commit -m 'Add amazing feature'`
6. **Push to the branch**: `git push origin feature/amazing-feature`
7. **Open a Pull Request**

### Development Guidelines

- Follow existing code style and conventions
- Add tests for new features
- Update documentation as needed
- Ensure all CI checks pass
- Use conventional commit messages

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Model Context Protocol](https://modelcontextprotocol.io/) specification
- [Anthropic](https://www.anthropic.com/) for MCP development
- All contributors and maintainers

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/your-org/mcp-streamable-http/issues)
- **Discussions**: [GitHub Discussions](https://github.com/your-org/mcp-streamable-http/discussions)
- **Documentation**: [Project Wiki](https://github.com/your-org/mcp-streamable-http/wiki)

---

**Built with ❤️ for the MCP community**
python client.py
```

This will start an **interactive chat loop** using the MCP Streamable HTTP protocol.  
If you started the MCP server on a different port, specify it using the `--mcp-localhost-port` flag:

```bash
python client.py --mcp-localhost-port=9000
```

### 3. Typescript Example

#### 1. Add Your Anthropic API Key

Update the `.env` file inside the `typescript-example/client` directory with the following content:

```env
ANTHROPIC_API_KEY=your_api_key_here
```

#### 2. Set Up the Server

```bash
cd typescript-example/server
npm install && npm run build
node build/index.js
```

By default, the server will start at `http://localhost:8123`.  
If you'd like to specify a different port, use the `--port` flag:

```bash
node build/index.js --port=9000
```

#### 3. Set Up the Client

```bash
cd ../client
npm install && npm run build
```

#### 4. Run the Client

```bash
node build/index.js
```

This will start an **interactive chat loop** using the MCP Streamable HTTP protocol.  
If you started the MCP server on a different port, specify it using the `--mcp-localhost-port` flag:

```bash
node build/index.js --mcp-localhost-port=9000
```

---

## 💬 Example Queries

In the client chat interface, you can ask questions like:

- “Are there any weather alerts in Sacramento?”
- “What’s the weather like in New York City?”
- “Tell me the forecast for Boston tomorrow.”

The client will forward requests to the local MCP weather server and return the results using Anthropic’s Claude language model. The MCP transport layer used will be Streamable HTTP.
