#!/bin/bash

# ──────────────────────────────────────────────────────────────
# 🎨 Terminal Colors
# ──────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

info()    { echo -e "${BLUE}${BOLD}→${NC} ${BLUE}$1${NC}"; }
success() { echo -e "${GREEN}${BOLD}✔${NC} ${GREEN}$1${NC}"; }
warn()    { echo -e "${YELLOW}${BOLD}!${NC} ${YELLOW}$1${NC}"; }
error()   { echo -e "${RED}${BOLD}✖${NC} ${RED}$1${NC}"; }
divider() { echo -e "${BOLD}──────────────────────────────────────────────${NC}"; }

# Ensure script is run from repo root
ROOT_DIR=$(pwd)
REMOTE_NAME="yt-v"
REMOTE_URL="https://github.com/PixelLineage/frameworks_base.git"   # <-- change this
BRANCH="q2"

COMMIT1="36dcbaae993a3a371d34b07377a05f059dca4b74"
COMMIT2="fb5c424ea93086880f0414086ab372a97f22da7a"   

# ──────────────────────────────────────────────────────────────
# clone_if_missing + clean_clone (with depth=2)
# ──────────────────────────────────────────────────────────────
clone_if_missing() {
    local repo_url=$1 branch=$2 target_dir=$3
    [ -z "$repo_url" ] || [ -z "$branch" ] || [ -z "$target_dir" ] && {
        error "Usage: clone_if_missing <repo_url> <branch> <target_dir>"
        return 1
    }

    if [ ! -d "$target_dir" ]; then
        info "Cloning $target_dir..."
        git clone --depth=2 "$repo_url" -b "$branch" "$target_dir" -q \
            && success "Done cloning $target_dir." || {
            error "Failed to clone $repo_url."
            return 1
        }
    else
        warn "$target_dir already exists, skipping."
    fi
    return 0
}

clean_clone() {
    local repo_url=$1 branch=$2 target_dir=$3
    [ -z "$repo_url" ] || [ -z "$branch" ] || [ -z "$target_dir" ] && {
        error "Usage: clean_clone <repo_url> <branch> <target_dir>"
        return 1
    }

    info "Fresh cloning $target_dir from $branch..."
    [ -d "$target_dir" ] && rm -rf "$target_dir" && success "Removed $target_dir."
    git clone --depth=2 "$repo_url" -b "$branch" "$target_dir" -q && \
        success "Cloned $target_dir." || {
        error "Clone failed."
        return 1
    }
    return 0
}

apply_commit() {
    local commit=$1

    # Check if commit already applied
    if git merge-base --is-ancestor "$commit" HEAD 2>/dev/null; then
        echo "Commit $commit already applied. Skipping."
        return
    fi

    echo "Applying commit $commit..."

    if git cherry-pick "$commit" >/dev/null 2>&1; then
        echo "Applied commit $commit successfully."
    else
        echo "Failed to apply commit $commit. Cleaning up..."

        git cherry-pick --abort >/dev/null 2>&1 || true
        git reset --hard HEAD >/dev/null 2>&1 || true
        git clean -fd >/dev/null 2>&1 || true
    fi
}

# ──────────────────────────────────────────────────────────────
# Apply Youtube Patch
# ──────────────────────────────────────────────────────────────
apply_youtube_patch() {
    cd "$ROOT_DIR"
    cd frameworks/base
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "Not inside a git repository. Exiting."
    #    exit 1
    fi

    # Add remote if it doesn't exist
    if ! git remote get-url "$REMOTE_NAME" >/dev/null 2>&1; then
        echo "Adding remote $REMOTE_NAME..."
        git remote add "$REMOTE_NAME" "$REMOTE_URL"
    else
        echo "Remote $REMOTE_NAME already exists."
    fi

    # Fetch remote
    echo "Fetching from $REMOTE_NAME..."
    git fetch "$REMOTE_NAME" "$BRANCH" >/dev/null 2>&1 || true

    # Apply the two commits
    apply_commit "$COMMIT1"
    apply_commit "$COMMIT2"
    cd "$ROOT_DIR"
    setup_yt_files

}

# ──────────────────────────────────────────────────────────────
# Extract Youtube Files
# ──────────────────────────────────────────────────────────────
setup_yt_files(){
    chmod +x vendor/revanced/extract-libs.sh
    bash vendor/revanced/extract-libs.sh
}

# ──────────────────────────────────────────────────────────────
# Run ksun Patch Setup
# ──────────────────────────────────────────────────────────────
apply_ksun_patch(){
    cd "$ROOT_DIR"
    cd kernel/realme/sm8250
    curl -LSs "https://raw.githubusercontent.com/KernelSU-Legacy/KernelSU-Legacy/v1.1.1/kernel/setup.sh" | bash -
    cd "$ROOT_DIR"
}

# ──────────────────────────────────────────────────────────────
# Kernel Repo
# ──────────────────────────────────────────────────────────────
divider
info "Cloning kernel into kernel/realme/sm8250..."
clone_if_missing "https://github.com/Matrixx-Devices/kernel_realme_bladerunner.git" "16.2" "kernel/realme/sm8250"
divider

# ──────────────────────────────────────────────────────────────
# Other Repos
# ──────────────────────────────────────────────────────────────
info "Setting up other repositories..."
clone_if_missing "https://github.com/Matrixx-Devices/vendor_realme_bladerunner.git" "16.2" "vendor/realme/bladerunner"
clone_if_missing "https://github.com/Matrixx-Devices/hardware_dolby.git" "16.2-munch" "hardware/dolby"
clone_if_missing "https://github.com/Matrixx-Devices/hardware_oplus.git"  "16.2" "hardware/oplus"
clone_if_missing "https://gitlab.com/AAMIRR-ALI/vendor-revanced.git"  "main" "vendor/revanced"
#clean_clone "https://github.com/PocoF3Releases/packages_resources_devicesettings.git" "aosp-16" "packages/resources/devicesettings"
divider




apply_youtube_patch
apply_ksun_patch


echo "-------------------------------------"
echo "           Setup complete!           "
echo "-------------------------------------"
