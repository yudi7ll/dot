# Makefile for dotfiles management

# Default directories
DOTFILES_DIR := files
STOW_DIR := files
STOW_IGNORE := --ignore='.*\.zwc'

# Colors for output
RED := \033[0;31m
GREEN := \033[0;32m
BLUE := \033[0;34m
NC := \033[0m # No Color

.PHONY: help install update clean status submodule-init submodule-update submodule-status

help:
	@echo "Dotfiles Management Makefile"
	@echo ""
	@echo "Usage:"
	@echo "  make install            Install all dotfiles using stow and initialize submodules"
	@echo "  make update             Update all dotfiles using stow and update submodules"
	@echo "  make clean              Remove all dotfiles symlinks"
	@echo "  make status             Show stow status"
	@echo "  make submodule-init     Initialize and clone all submodules"
	@echo "  make submodule-update   Update all submodules to latest versions"
	@echo "  make submodule-status   Show submodule status"
	@echo "  make help               Show this help message"
	@echo ""
	@echo "For individual packages, use stow directly:"
	@echo "  stow --dir=files --target=\$$HOME --verbose .zshrc .p10k.zsh .config/zsh"
	@echo "  stow --dir=files --target=\$$HOME --verbose .config/wezterm"
	@echo "  stow --dir=files --target=\$$HOME --verbose .config/kitty"
	@echo "  stow --dir=files --target=\$$HOME --verbose .config/oh-my-zsh"

# Install all dotfiles
install:
	@echo -e "$(BLUE)Installing all submodules...$(NC)"
	make submodule-init
	@echo -e "$(GREEN)All submodules installed successfully!$(NC)"
	@echo -e ""
	@echo -e "$(BLUE)Installing all dotfiles...$(NC)"
	stow --dir=$(STOW_DIR) --target=$(HOME) --verbose $(STOW_IGNORE) .
	@echo -e "$(GREEN)All dotfiles installed successfully!$(NC)"
	@echo -e ""
	@echo -e "$(BLUE)Updating submodules to latest versions...$(NC)"
	make submodule-update

# Update all dotfiles (restow) and submodules
update:
	@echo -e "$(BLUE)Updating submodules...$(NC)"
	git submodule update --remote --merge
	@echo -e "$(GREEN)Submodules updated successfully!$(NC)"
	@echo -e "$(BLUE)Updating all dotfiles...$(NC)"
	stow --dir=$(STOW_DIR) --target=$(HOME) --restow $(STOW_IGNORE) .
	@echo -e "$(GREEN)All dotfiles updated successfully!$(NC)"

# Clean all dotfiles (remove symlinks)
clean:
	@echo -e "$(BLUE)Removing all dotfiles symlinks...$(NC)"
	stow --dir=$(STOW_DIR) --target=$(HOME) --delete $(STOW_IGNORE) .
	@echo -e "$(GREEN)All dotfiles symlinks removed!$(NC)"

# Show stow status
status:
	@echo -e "$(BLUE)Current stow status:$(NC)"
	stow --dir=$(STOW_DIR) --target=$(HOME) --verbose --no-folding $(STOW_IGNORE) .

# Check if stow is installed
check-stow:
	@which stow > /dev/null || (echo "stow is not installed. Please install it with: sudo apt install stow (Ubuntu/Debian) or brew install stow (macOS)" && exit 1)

# Bootstrap target to set up the environment
bootstrap: check-stow
	@echo -e "$(BLUE)Setting up dotfiles...$(NC)"
	stow --dir=$(STOW_DIR) --target=$(HOME) --verbose $(STOW_IGNORE) .
	@echo -e "$(GREEN)Dotfiles setup complete!$(NC)"

# Initialize and clone all submodules
submodule-init:
	@echo -e "$(BLUE)Initializing and cloning all submodules...$(NC)"
	git submodule update --init --recursive
	@echo -e "$(GREEN)All submodules initialized and cloned!$(NC)"

# Update all submodules to their latest versions
submodule-update:
	@echo -e "$(BLUE)Updating all submodules to latest versions...$(NC)"
	git submodule update --remote --merge
	@echo -e "$(GREEN)All submodules updated!$(NC)"

# Show submodule status
submodule-status:
	@echo -e "$(BLUE)Submodule status:$(NC)"
	git submodule status

# List all files that would be stowed
list:
	@echo -e "$(BLUE)Files that will be managed by stow:$(NC)"
	find $(DOTFILES_DIR) -type f -not -path "*/.git/*" -not -name ".git" | while read file; do \
		echo "  $$file"; \
	done
