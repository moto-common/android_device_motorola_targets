# Copyright 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ifneq (,$(filter 5.4 5.10 5.15, $(TARGET_KERNEL_VERSION)))
  TARGET_KERNEL_IMAGE_NAME := Image
else
  TARGET_KERNEL_IMAGE_NAME := Image.gz
endif

TARGET_PREBUILT_KERNEL := $(TARGET_DEVICE_DIR)-kernel/$(TARGET_KERNEL_IMAGE_NAME)

PRODUCT_COPY_FILES += \
    $(TARGET_PREBUILT_KERNEL):kernel

# Modules
ifneq ($(BOOT_KERNEL_MODULES),)
  BOARD_VENDOR_RAMDISK_KERNEL_MODULES := \
      $(foreach module,$(BOOT_KERNEL_MODULES),$(TARGET_DEVICE_DIR)-kernel/modules/$(module))
endif
