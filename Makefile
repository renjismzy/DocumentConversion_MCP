.PHONY: help install build start stop clean test docker-build docker-up docker-down

# Default target
help:
	@echo "Available commands:"
	@echo "  install       - Install all dependencies"
	@echo "  build         - Build all projects"
	@echo "  start         - Start all servers"
	@echo "  stop          - Stop all running servers"
	@echo "  clean         - Clean build artifacts"
	@echo "  test          - Run all tests"
	@echo "  docker-build  - Build Docker images"
	@echo "  docker-up     - Start Docker containers"
	@echo "  docker-down   - Stop Docker containers"
	@echo ""
	@echo "Python servers:"
	@echo "  start-python-http   - Start Python HTTP server"
	@echo "  start-python-stdio  - Start Python Stdio server"
	@echo ""
	@echo "TypeScript servers:"
	@echo "  start-ts-http       - Start TypeScript HTTP server"
	@echo "  start-ts-stdio      - Start TypeScript Stdio server"

# Installation targets
install:
	npm run install:all

install-python:
	cd document-converter/server && pip install -e .

install-typescript:
	cd document-converter/typescript-server && npm install

install-examples:
	cd python-example/client && pip install -e .
	cd typescript-example/client && npm install
	cd typescript-example/server && npm install

# Build targets
build:
	npm run build:all

build-typescript:
	cd document-converter/typescript-server && npm run build

build-examples:
	cd typescript-example/server && npm run build
	cd typescript-example/client && npm run build

# Start servers
start-python-http:
	cd document-converter/server && python document_converter.py

start-python-stdio:
	cd document-converter/server && python stdio_server.py

start-ts-http:
	cd document-converter/typescript-server && npm start

start-ts-stdio:
	cd document-converter/typescript-server && npm run start:stdio

# Development servers
dev-python-http:
	cd document-converter/server && python document_converter.py

dev-ts-http:
	cd document-converter/typescript-server && npm run dev

dev-ts-stdio:
	cd document-converter/typescript-server && npm run dev:stdio

# Docker targets
docker-build:
	docker-compose build

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down

docker-logs:
	docker-compose logs -f

# Testing
test:
	@echo "Running Python tests..."
	cd python-example && python -m pytest || true
	@echo "Running TypeScript tests..."
	cd typescript-example && npm test || true

# Cleanup
clean:
	npm run clean

clean-typescript:
	cd document-converter/typescript-server && npm run clean

clean-examples:
	cd typescript-example/server && npm run clean
	cd typescript-example/client && npm run clean

clean-docker:
	docker-compose down -v
	docker system prune -f

# Health checks
health-check:
	@echo "Checking server health..."
	@curl -f http://localhost:3000/health || echo "Python server not responding"
	@curl -f http://localhost:3001/health || echo "TypeScript server not responding"

# Development utilities
format:
	@echo "Formatting Python code..."
	cd document-converter/server && black . || true
	cd python-example && black . || true
	@echo "Formatting TypeScript code..."
	cd document-converter/typescript-server && npx prettier --write . || true
	cd typescript-example && npx prettier --write . || true

lint:
	@echo "Linting Python code..."
	cd document-converter/server && flake8 . || true
	cd python-example && flake8 . || true
	@echo "Linting TypeScript code..."
	cd document-converter/typescript-server && npx eslint . || true
	cd typescript-example && npx eslint . || true