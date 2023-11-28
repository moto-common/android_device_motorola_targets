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

# Device
## Extract device name from TARGET_PRODUCT
## Account for target product value containing
## no prefix
DEVICE := $(subst _, ,$(TARGET_PRODUCT))
ifneq ($(words $(DEVICE)), 1)
  DEVICE := $(subst $() ,_,$(filter-out $(firstword $(DEVICE)),$(DEVICE)))
endif

# Brand
PRODUCT_BRAND := motorola

# Device
PRODUCT_DEVICE := $(DEVICE)

# Manufacturer
PRODUCT_MANUFACTURER := motorola

# Required Inheritance
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# NoNearbySharingOverlay
PRODUCT_PACKAGES += \
    NoNearbySharingOverlay

# ROM Name
ROM_NAME := $(firstword $(subst _, ,$(TARGET_PRODUCT)))

# Utils
include device/motorola/targets/include/utils.mk

# Inherit device makefile
include device/motorola/$(DEVICE)/device.mk
