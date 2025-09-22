#!/bin/bash

# Script to switch to GUI mode on next reboot
# This configures the system to boot to graphical target (with GUI)
# and removes auto-login configuration

echo "Configuring system for GUI mode on next reboot..."

# Set default target to graphical (with GUI)
sudo systemctl set-default graphical.target
if [ $? -eq 0 ]; then
    echo "✓ Set boot target to graphical (GUI)"
else
    echo "✗ Failed to set boot target"
    exit 1
fi

# Remove auto-login configuration
if [ -f /etc/systemd/system/getty@tty1.service.d/override.conf ]; then
    sudo rm -f /etc/systemd/system/getty@tty1.service.d/override.conf
    echo "✓ Removed auto-login configuration"
else
    echo "✓ Auto-login configuration not present"
fi

# Remove the directory if it's empty
if [ -d /etc/systemd/system/getty@tty1.service.d/ ] && [ -z "$(ls -A /etc/systemd/system/getty@tty1.service.d/)" ]; then
    sudo rmdir /etc/systemd/system/getty@tty1.service.d/
fi

# Reload systemd
sudo systemctl daemon-reload

echo ""
echo "Configuration complete! The system will boot to GUI mode after reboot."
echo "SSH will still be available at: $(hostname -I | awk '{print $1}')"
echo ""
echo "To reboot now, run: sudo reboot"
echo "To switch back to headless mode, run: headless-on-reboot"