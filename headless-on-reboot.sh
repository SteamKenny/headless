#!/bin/bash

# Script to switch to headless mode on next reboot
# This configures the system to boot to multi-user target (no GUI)
# and sets up auto-login to console

echo "Configuring system for headless mode on next reboot..."

# Set default target to multi-user (no GUI)
sudo systemctl set-default multi-user.target
if [ $? -eq 0 ]; then
    echo "✓ Set boot target to multi-user (headless)"
else
    echo "✗ Failed to set boot target"
    exit 1
fi

# Set AUTO_LOGIN to "true" to enable autologin, "false" to disable
AUTO_LOGIN="${AUTO_LOGIN:-false}"

# To keep auto-login disabled (default): run the script normally.
# To enable it temporarily: AUTO_LOGIN=true ./headless-on-reboot.sh
# Or set AUTO_LOGIN=true in an environment file or wrapper if you want it to persist.

sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/

if [ "$AUTO_LOGIN" = "true" ]; then
  echo "Configuring auto-login for console (AUTO_LOGIN=true)"
  sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf > /dev/null << EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --noissue --autologin $(whoami) %I \$TERM
EOF
else
  echo "Configuring console without auto-login (AUTO_LOGIN=false)"
  sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf > /dev/null << EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --noissue %I \$TERM
EOF
fi


if [ $? -eq 0 ]; then
    echo "✓ Configured auto-login to console"
else
    echo "✗ Failed to configure auto-login"
    exit 1
fi

# Reload systemd
sudo systemctl daemon-reload

echo ""
echo "Configuration complete! The system will boot to headless mode after reboot."
echo "SSH is available at: $(hostname -I | awk '{print $1}')"
echo ""
echo "To reboot now, run: sudo reboot"
echo "To switch back to GUI mode, run: gui-on-reboot"
