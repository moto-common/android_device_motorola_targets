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

include device/motorola/targets/include/kernel/common.mk

# Handle copying the kernel ourselves
TARGET_NO_KERNEL_OVERRIDE := true
TARGET_PREBUILT_KERNEL := $(TARGET_DEVICE_DIR)-kernel/$(TARGET_KERNEL_IMAGE_NAME)
PRODUCT_COPY_FILES += \
    $(TARGET_PREBUILT_KERNEL):kernel

# DTB
BOARD_PREBUILT_DTBIMAGE_DIR ?= device/motorola/$(PRODUCT_DEVICE)-kernel/dtbs

# DTBO
ifeq ($(call has-partition,dtbo),true)
  # Claims no dtbo but has the partition, assume prebuilt dtbo provided.
  BOARD_PREBUILT_DTBOIMAGE ?= device/motorola/$(PRODUCT_DEVICE)-kernel/dtbo.img
endif

# Modules
## Amogus can't handle stripped vendor modules for now
ifneq ($(call is-kernel-greater-than-or-equal-to,4.19),true)
  BOARD_DO_NOT_STRIP_VENDOR_MODULES := true
endif

## Vendor Modules
BOARD_VENDOR_KERNEL_MODULES ?= \
    $(wildcard device/motorola/$(DEVICE)-kernel/modules/*.ko)
## Vendor_boot Modules
ifneq ($(BOOT_KERNEL_MODULES),)
  BOARD_VENDOR_RAMDISK_KERNEL_MODULES := \
      $(foreach module,$(BOOT_KERNEL_MODULES),device/motorola/$(DEVICE)-kernel/modules/$(module))
endif

# Force prebuilt kernel, user inclded this makefile for a reason
TARGET_FORCE_PREBUILT_KERNEL := true
# Declare kernel config and source for headers
TARGET_KERNEL_CONFIG := vendor/$(DEVICE)_defconfig
ifeq ($(PRODUCT_USES_QCOM_HARDWARE),true)
  TARGET_KERNEL_SOURCE := kernel/motorola/msm-$(TARGET_KERNEL_VERSION)
else ifeq ($(PRODUCT_USES_MTK_HARDWARE),true)
  TARGET_KERNEL_SOURCE := kernel/motorola/$(TARGET_BOARD_PLATFORM)
else
  $(error Target's hardware is not supported...)
endif
