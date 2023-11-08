
APP_NAME           ?= alafia-conn-toolbox
HOST_NAME          = #none
HOST_IP            = #none

DOCKER_IMAGE_NAME  ?= $(APP_NAME)
DOCKER_IMAGE_TAG   ?= latest
DOCKER_CONTEXT     ?= ./build
DOCKERFILE         ?= ./build/Dockerfile
DEPLOY_PATH        ?= ./deploy
SERVICE_FILE       ?= $(APP_NAME).service
DESKTOP_FILE       ?= $(APP_NAME).desktop
APPLICATIONS_DIR   ?= /usr/share/applications
MODIFYHOSTS_SCRIPT ?= ../modify-hosts.sh

# Build the Docker image
build:
	@echo "Building Docker image..."
	docker build --no-cache -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) -f $(DOCKERFILE) $(DOCKER_CONTEXT)
	@echo "Docker image built successfully."

# Install the systemd service
install:
	@echo "Installing systemd service..."
	sudo cp $(DEPLOY_PATH)/$(SERVICE_FILE) /etc/systemd/system/
	sudo systemctl enable --now $(SERVICE_FILE)
	@echo "Systemd service installed and started successfully."

	@echo "Installing desktop entry..."
	sudo cp $(DEPLOY_PATH)/$(DESKTOP_FILE) $(APPLICATIONS_DIR)
	@echo "Desktop entry installed successfully."

	@if [ -z "$(HOST_NAME)" ]; then \
		echo "HOST_NAME is not set. Skipping hosts modification."; \
        else \
		@echo "Adding entry to /etc/hosts..." && \
		sudo $(MODIFYHOSTS_SCRIPT) $(HOST_IP) $(HOST_NAME) add && \
		@echo "Entry added to /etc/hosts successfully."; \
	fi

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

	@if [ -z "$(HOST_NAME)" ]; then \
		echo "HOST_NAME is not set. Skipping hosts modification."; \
        else \
		@echo "Removing entry from /etc/hosts..." && \
		sudo $(HOSTS_SCRIPT) $(HOST_IP) $(HOST_NAME) remove && \
		@echo "Entry removed from /etc/hosts successfully."; \
	fi

.PHONY: build install push uninstall

