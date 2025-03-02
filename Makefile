# Default target is help
.DEFAULT_GOAL := help

# Load environment variables from .env file if it exists
ifneq (,$(wildcard .env))
    include .env
    export $(shell sed 's/=.*//' .env)
endif

# Default Variables
IMAGE_NAME = nodejs-template
TAG ?= latest  # Default tag is 'latest' unless provided
CONTAINER_NAME = nodejs-template-container
PORT ?= 3000   # Use exported ENV PORT or default to 3000

# Display help menu
help:
	@echo "Available commands:"
	@echo "  make build TAG=<tag>   - Build the Docker image with a specific tag (default: latest)"
	@echo "  make run               - Run the container using PORT from .env or default (3000)"
	@echo "  make stop              - Stop the container"
	@echo "  make clean             - Remove the container and image"
	@echo "  make ps                - Show running containers"
	@echo "  make logs              - Show logs of the running container"
	@echo "  make format            - Format code using Prettier"
	@echo "  make lint              - Check code formatting with Prettier"

# Build the Docker image with a specified tag
build:
	docker build -t $(IMAGE_NAME):$(TAG) . -f docker/Dockerfile

# Run the container with the specified PORT
run:
	docker run -d --name $(CONTAINER_NAME) -p $(PORT):$(PORT) $(IMAGE_NAME):$(TAG)

# Stop the container
stop:
	docker stop $(CONTAINER_NAME)

# Remove the container & image
clean:
	docker rm -f $(CONTAINER_NAME) || true
	docker rmi -f $(IMAGE_NAME):$(TAG) || true

# Show running containers
ps:
	docker ps -a

# Show logs from the running container
logs:
	docker logs -f $(CONTAINER_NAME)

# Format code using Prettier
format:
	npx prettier --write .

# Lint code using Prettier
lint:
	npx prettier --check .
