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

ifeq ($(call is-kernel-greater-than-or-equal-to,5.10),true)
  TARGET_KERNEL_NO_GCC := true
endif

ifeq ($(call is-kernel-greater-than-or-equal-to,5.4),true)
  TARGET_KERNEL_CLANG_VERSION := r450784e
  TARGET_KERNEL_LLVM_BINUTILS := true
else
  TARGET_KERNEL_CLANG_VERSION := r383902
  TARGET_KERNEL_LLVM_BINUTILS := false
endif
TARGET_KERNEL_NO_GCC ?= false
TARGET_KERNEL_CONFIG := vendor/$(DEVICE)_defconfig
ifeq ($(TARGET_USES_DTB_FROM_SOURCE),false)
  BOARD_PREBUILT_DTBIMAGE_DIR := device/motorola/$(DEVICE)-kernel/dtbs
  ifeq ($(call has-partition,dtbo),true)
    BOARD_PREBUILT_DTBOIMAGE := device/motorola/$(DEVICE)-kernel/dtbo.img
  endif
endif
ifeq ($(PRODUCT_USES_QCOM_HARDWARE),true)
  TARGET_KERNEL_SOURCE := kernel/motorola/msm-$(TARGET_KERNEL_VERSION)
else ifeq ($(PRODUCT_USES_MTK_HARDWARE),true)
  TARGET_KERNEL_SOURCE := kernel/motorola/$(TARGET_BOARD_PLATFORM)
else
  $(warning Target's hardware is not supported...)
endif
