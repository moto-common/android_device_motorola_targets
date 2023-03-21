#!/bin/bash
# Replace vendor.camera.aux.packagelist and vendor_persist_camera_prop
shopt -s extglob
read -p "Please run this script at the root of your synced source!, Ctrl-C to exit at this point, Enter to continue."
find device/!(*qcom)/sepolicy -type f -exec sed -i "/vendor.camera.aux.packagelist/s/.*//" {} \;
if [ $? -eq 0 ]; then
	echo "Patch 1, Done!"
else
	echo "Patch 1, Failed..."
fi
find device/!(*qcom)/sepolicy -type f -exec sed -i "/system_vendor_config_prop(vendor_persist_camera_prop)/s/.*//" {} \;
if [ $? -eq 0 ]; then
	echo "Patch 2, Done!"
else
	echo "Patch 2, Failed..."
fi
