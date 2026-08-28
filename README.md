> [!NOTE]
> This is a minor modification to allow the scripts to work with Zorin systems.  It may work with others, but this has NOT been tested!

# Linux Headless Mode Scripts

Easy switching between headless and GUI modes on Zorin systems.

## Overview

This repository contains scripts to quickly switch between desktop GUI mode and headless server mode on Zorin systems. Perfect for machines that need to operate as both desktop workstations and headless servers.

## Features

- 🖥️ **GUI Mode**: Full desktop environment with graphical interface
- 🖤 **Headless Mode**: Console-only mode with auto-login for server operation
- 🔄 **Easy Switching**: Simple commands to toggle between modes
- 🌐 **SSH Access**: Always maintains SSH connectivity for remote access

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/SteamKenny/headless.git
   cd headless
   ```

2. Make scripts executable:
   ```bash
   chmod +x *.sh
   ```

3. Install scripts system-wide:
   ```bash
   sudo ln -sf $(pwd)/headless-on-reboot.sh /usr/local/bin/headless-on-reboot
   sudo ln -sf $(pwd)/gui-on-reboot.sh /usr/local/bin/gui-on-reboot
   ```

## Usage

### Switch to Headless Mode
```bash
headless-on-reboot
sudo reboot
```

### Switch to Headless Mode (auto login)
```bash
AUTO_LOGIN=true ./headless-on-reboot.sh
sudo reboot
```

### Switch to GUI Mode
```bash
gui-on-reboot
sudo reboot
```

## What It Does

### Headless Mode
- Sets systemd target to `multi-user.target`
- Removes grub splash (enables text boot)
- Configures auto-login to console (opt-in)
- Maintains SSH server access
- Saves system resources by not loading GUI

### GUI Mode
- Sets systemd target to `graphical.target`
- Enables grub splash
- Removes auto-login configuration
- Returns to normal desktop login
- Maintains SSH server access

## Requirements

- Zorin (tested) or Ubuntu-based systems
- systemd-based system
- sudo access for system configuration

## Remote Access

SSH server is automatically configured and will be available at your system's IP address:
```bash
ssh username@your-ip-address
```

## License

MIT License - feel free to use and modify as needed.
