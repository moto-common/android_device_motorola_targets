#!/bin/bash
# Sanity checking
[ ! -f "devices/template/template.mk" ] || [ ! -f "devices/template/aosp_template.mk" ] && \
    echo "Please run this script in the root of the targets repo" && exit 1

# Ask about the target
read -r -p "Device Model Name: " DEVICE_NAME
read -r -p "RAM amount in Gigabytes: " DEVICE_RAM
DEVICE_RAM="${DEVICE_RAM:0:1}"
read -r -p "Device Codename: " DEVICE_CODENAME

[ -z "$DEVICE_NAME" ] || [ -z "$DEVICE_RAM" ] || [ -z "$DEVICE_CODENAME" ] && \
    echo "Invalid values entered, please try again..." && exit 1

# Setup device directory
[ -d devices/"$DEVICE_NAME" ] && echo "Device already exists..." && exit 1

cp -ra devices/template devices/"$DEVICE_CODENAME"
mv devices/"$DEVICE_CODENAME"/template.mk devices/"$DEVICE_CODENAME"/"$DEVICE_CODENAME".mk
mv devices/"$DEVICE_CODENAME"/aosp_template.mk devices/"$DEVICE_CODENAME"/aosp_"$DEVICE_CODENAME".mk

# Dalvik heap configuration
case "$DEVICE_RAM" in
    2)
      sed -i 's;TEMPLATE_DALVIK_HEAP_INCLUDE;$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk);g' \
          devices/"$DEVICE_CODENAME"/"$DEVICE_CODENAME".mk
      ;;

    3)
      sed -i 's;TEMPLATE_DALVIK_HEAP_INCLUDE;$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk);g' \
          devices/"$DEVICE_CODENAME"/"$DEVICE_CODENAME".mk
      ;;

    4)
      sed -i 's;TEMPLATE_DALVIK_HEAP_INCLUDE;$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk);g' \
          devices/"$DEVICE_CODENAME"/"$DEVICE_CODENAME".mk
      ;;

    6)
      sed -i 's;TEMPLATE_DALVIK_HEAP_INCLUDE;$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk);g' \
          devices/"$DEVICE_CODENAME"/"$DEVICE_CODENAME".mk
      ;;

    *)
      sed -i 's;TEMPLATE_DALVIK_HEAP_INCLUDE;$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk);g' \
          devices/"$DEVICE_CODENAME"/"$DEVICE_CODENAME".mk
      ;;
esac

# Change device specific naming
sed -i 's/TEMPLATE_MODEL/'"$DEVICE_NAME"'/g' devices/"$DEVICE_CODENAME"/"$DEVICE_CODENAME".mk
sed -i 's/TEMPLATE/'"$DEVICE_CODENAME"'/g' devices/"$DEVICE_CODENAME"/"$DEVICE_CODENAME".mk
sed -i 's/TEMPLATE/'"$DEVICE_CODENAME"'/g' devices/"$DEVICE_CODENAME"/aosp_"$DEVICE_CODENAME".mk

echo "Done! Check devices/ for your new device folder."
