#!/bin/bash

ROM_DIR="rom"
DEVICE_DIR="devices"

if [ ! -d $ROM_DIR ] || [ ! -d $DEVICE_DIR ]; then
  echo "Please run this script in device/motorola/targets..."
  exit 1
fi

for device in $DEVICE_DIR/*; do
  for file in $ROM_DIR/*; do
    ln -sf "../../$file" "$device/$(basename ${file%.*})_$(basename $device).mk"
  done
done
