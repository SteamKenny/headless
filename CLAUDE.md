# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This repository contains Linux system configuration utilities for switching between headless and GUI modes on Linux Mint systems. It was created to manage server/desktop mode transitions with automated scripts.

## Key Scripts and Commands

### System Mode Switching
- `headless-on-reboot` - Configure system to boot into headless mode (multi-user target) with auto-login
- `gui-on-reboot` - Configure system to boot into GUI mode (graphical target) with normal login

### Script Locations
- `/home/kh0pp/headless-on-reboot.sh` - Headless mode configuration script
- `/home/kh0pp/gui-on-reboot.sh` - GUI mode configuration script
- Commands are symlinked to `/usr/local/bin/` for system-wide access

## System Architecture

### Mode Switching Mechanism
The scripts work by manipulating systemd targets:
- **Headless mode**: Sets `multi-user.target` as default, configures auto-login via getty service override
- **GUI mode**: Sets `graphical.target` as default, removes auto-login configuration

### SSH Configuration
SSH server is installed and enabled across both modes to ensure remote access is always available.

### Dependencies
- Requires sudo access for systemd configuration changes
- Uses systemctl for target management
- Relies on getty service for auto-login functionality

## Claude Code Permissions

The repository includes specific permissions for system administration tasks:
- System service management (`systemctl`)
- Network configuration (`ip addr`)
- Package management (`apt`)
- File permissions (`chmod`)
- General sudo access for system configuration

## Usage Patterns

When working with this repository, Claude Code can:
1. Modify the switching scripts to add new functionality
2. Create additional system configuration utilities
3. Manage systemd service configurations
4. Handle network and SSH setup tasks

The scripts are designed to be idempotent and provide clear feedback on configuration changes.