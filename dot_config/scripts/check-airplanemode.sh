#!/bin/bash

# Check if airplane mode is active (rfkill blocks Wi-Fi or Bluetooth)
if rfkill list | grep -q "Soft blocked: yes"; then
    echo "{\"text\": \"On\", \"tooltip\": \"Airplane Mode: Enabled\"}"
else
    echo "{\"text\": \"Off\", \"tooltip\": \"Airplane Mode: Disabled\"}"
fi
