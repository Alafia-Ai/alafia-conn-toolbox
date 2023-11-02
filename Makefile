APP_NAME           ?= alafia-conn-toolbox

DOCKER_IMAGE_NAME  ?= $(APP_NAME)
DOCKER_IMAGE_TAG   ?= latest
DOCKER_CONTEXT     ?= ./docker
DOCKERHUB_USERNAME ?= pdlloyd
DOCKERFILE         ?= ./docker/Dockerfile
SERVICE_FILE       ?= ./app/$(APP_NAME).service
DESKTOP_FILE       ?= ./app/$(APP_NAME).desktop
ICON_FILE          ?= ./app/$(APP_NAME).svg
MODIFYHOSTS_FILE   ?= ../modify-hosts.sh
HOST_NAME          ?= conn.alafia
HOST_IP            ?= 127.0.0.1
APPLICATIONS_DIR   ?= /usr/share/applications #fixme

# Build the Docker image
build:
	@echo "Building Docker image..."
	docker build --no-cache -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) -f $(DOCKERFILE) $(DOCKER_CONTEXT)
	@echo "Docker image built successfully."

# Install the systemd service
install:
	@echo "Installing systemd service..."
	sudo cp $(SERVICE_FILE) /etc/systemd/system/
	sudo systemctl enable --now $(SERVICE_FILE)
	@echo "Systemd service installed and started successfully."

	@echo "Installing desktop entry..."
	sudo cp $(DESKTOP_FILE) $(APPLICATIONS_DIR)
	@echo "Desktop entry installed successfully."

	@echo "Adding entry to /etc/hosts..."
	sudo $(HOSTS_SCRIPT) $(HOST_IP) $(HOST_NAME) add
	@echo "Entry added to /etc/hosts successfully."

# Push the Docker image to Docker Hub
push:
	@echo "Pushing Docker image to Docker Hub..."
	docker push $(DOCKERHUB_USERNAME)/$(IMAGE_NAME):$(IMAGE_TAG)
	@echo "Docker image pushed successfully."

# Uninstall the systemd service and remove all installed files
uninstall:
	@echo "Stopping and disabling systemd service..."
	sudo systemctl stop $(SERVICE_FILE)
	sudo systemctl disable $(SERVICE_FILE)
	sudo rm -f /etc/systemd/system/$(SERVICE_FILE)
	@echo "Systemd service stopped, disabled, and removed successfully."

	@echo "Removing desktop entry..."
	sudo rm -f $(APPLICATIONS_DIR)/$(DESKTOP_FILE)
	@echo "Desktop entry removed successfully."

	@echo "Removing entry from /etc/hosts..."
	sudo $(HOSTS_SCRIPT) $(HOST_IP) $(HOST_NAME) remove
	@echo "Entry removed from /etc/hosts successfully."

.PHONY: build install push uninstall

