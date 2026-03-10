#!/bin/bash

# Check if airplane mode is active (rfkill blocks Wi-Fi or Bluetooth)
if rfkill list | grep -q "Soft blocked: yes"; then
    # Disable airplane mode (unblock Wi-Fi and Bluetooth)
    rfkill unblock all
    nmcli radio wifi on
    # Re-enable Bluetooth if desired
    bluetoothctl power on
    notify-send "Airplane Mode" "Airplane mode disabled"
    echo "{\"text\": \"Off\", \"tooltip\": \"Airplane Mode: Disabled\"}"
else
    # Enable airplane mode (block Wi-Fi and Bluetooth)
    nmcli radio wifi off
    bluetoothctl power off
    rfkill block all
    notify-send "Airplane Mode" "Airplane mode enabled"
    echo "{\"text\": \"On\", \"tooltip\": \"Airplane Mode: Enabled\"}"
fi
