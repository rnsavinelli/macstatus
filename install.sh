#!/bin/bash

# Function to print messages in color
print_info() {
    echo -e "\033[1;34m:: $1\033[0m"
}

print_warn() {
    echo -e "\033[1;33m!! $1\033[0m"
}

print_success() {
    echo -e "\033[1;32m✓ $1\033[0m"
}

print_error() {
    echo -e "\033[1;31m✗ $1\033[0m"
}

# Confirm step
confirm() {
    read -p "$1 (y/n): " choice
    case "$choice" in 
        y|Y ) return 0 ;;
        * ) return 1 ;;
    esac
}

print_info "Script Monitor Installer"

if confirm "Proceed with the installation of \"Script Monitor.app\"?"; then
    print_info "Removing old local build of \"Script Monitor.app\""
    rm -fr ./Script\ Monitor.app 
    print_success "Old build removed."

    print_info "Compiling \"Script Monitor.applescript\"..."
    if osacompile -o Script\ Monitor.app Script\ Monitor.applescript; then
        print_success "Compiled successfully."
    else
        print_error "Compilation failed. Exiting."
        exit 1
    fi

    print_info "Patching Info.plist..."
    if patch ./Script\ Monitor.app/Contents/Info.plist < ./patches/Info.plist.patch; then
        print_success "Info.plist patched."
    else
        print_error "Failed to patch Info.plist."
        exit 1
    fi

    if confirm "Remove old installed version in /Applications/Utilities/ and replace it with the new build?"; then
        sudo rm -rf /Applications/Utilities/Script\ Monitor.app
        print_success "Old installed version removed."
        print_info "Moving new build to /Applications/Utilities/..."
        if sudo mv ./Script\ Monitor.app /Applications/Utilities/; then
            print_success "Moved successfully."
        else
            print_error "Failed to move app. Exiting."
            exit 1
        fi
    else
        print_warn "Installation halted."
        exit 0
    fi

    if confirm "Add \"Script Monitor.app\" as a Login Item?"; then
        osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Utilities/Script Monitor.app", hidden:false}'
        print_success "Added to login items."
    else
        print_warn "Skipped adding to login items."
    fi

    print_success "Installation complete."      
else
    print_warn "Installation cancelled."
fi