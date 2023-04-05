#!/bin/bash

ROM_DIR="rom"
DEVICE_DIR="devices"

for device in $DEVICE_DIR/*; do
  for file in $ROM_DIR/*; do
    ln -sf "../../$file" "$device/$(basename ${file%.*})_$(basename $device).mk"
  done
done
