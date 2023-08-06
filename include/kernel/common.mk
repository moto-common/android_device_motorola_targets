# Kernel Image name
ifeq ($(call is-kernel-greater-than-or-equal-to,5.4),true)
  TARGET_KERNEL_IMAGE_NAME ?= Image
else ifeq ($(TARGET_KERNEL_VERSION),4.19)
  TARGET_KERNEL_IMAGE_NAME ?= Image.gz
else ifeq ($(TARGET_KERNEL_VERSION),4.14)
  TARGET_KERNEL_IMAGE_NAME ?= Image.gz-dtb
endif
