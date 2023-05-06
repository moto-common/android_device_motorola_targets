# Variables

## Define the available fstab filenames
# A/B, Non Dynamic, No system_ext nor product.
FSTAB_LEGACY := fstab_legacy
# A/B, Dynamic, No system_ext.
FSTAB_DYNAMIC := fstab_dynamic
# A/B, Dynamic, system_ext.
FSTAB_DYNAMIC_SYSTEM_EXT := fstab_dynamic_system_ext

# $(call copy-files-recursive,src,dst)
# copies files from src to dst recursively
# without root.
# How it works:
#  1. `$(foreach file,$(shell find $(SRC_DIR) -type f), ...)`
#     uses the `find` command to recursively search for files
#     in the source directory and its subdirectories.
#     The `-type f` option specifies that only files
#     should be returned, not directories.
#  2. For each file found by `find`, the rule copies the file
#     without the directory stem to the destination directory
#     using PRODUCT_COPY_FILES.
#
# Note that this rule will copy all files in the source directory
# and its subdirectories to the corresponding directory. Preserving
# structure.

define copy-files-recursive
 $(foreach file,$(shell find $(1) -type f), \
   $(eval PRODUCT_COPY_FILES += $(file):$(2)/$(patsubst $(1)/%,%,$(dir $(file)))$(notdir $(file))) \
 )
endef

# $(call device-has-characteristic,characteristic)
# checks if the target has a certain characteristic.
# Returns "true" if the characteristic is defined in
# the DEVICE_CHARACTERISTICS list and "false" otherwise.
# How it works:
#  1. $(filter $(1),$(DEVICE_CHARACTERISTICS))
#     filters the DEVICE_CHARACTERISTICS list for the
#     specified characteristic.
#  2. If the characteristic is found in the list, the
#     function returns "true". Otherwise, it returns "false".

define device-has-characteristic
$(if $(filter $(1),$(DEVICE_CHARACTERISTICS)),true,false)
endef

# $(call has-partition,partition_name)
# Returns true if the `partition_name` is present in the `AB_OTA_PARTITIONS` variable,
# false otherwise.
#
# How it works:
#  - Uses the `findstring` function to search for the `partition_name` in the
#    `AB_OTA_PARTITIONS` variable.
#  - Returns `true` if the `partition_name` is found, `false` otherwise.

define has-partition
$(strip $(if $(findstring $(1),$(AB_OTA_PARTITIONS)),true,false))
endef

# $(call select-fstab,hardware)
# Selects the appropriate fstab file based on available variables.
#
# How it works:
#  - If the target uses dynamic partitions and has a `system_ext` partition,
#    the function returns `$(FSTAB_DYNAMIC_SYSTEM_EXT).$(hardware)`.
#  - If the target uses dynamic partitions but does not have a `system_ext`
#    partition, the function returns `$(FSTAB_DYNAMIC).$(hardware)`.
#  - If the target does not use dynamic partitions, the function returns
#    `$(FSTAB_LEGACY).$(hardware)`.
#
# Example output: fstab_dynamic.qcom

define select-fstab
$(strip $(if $(filter true,$(TARGET_USES_DYNAMIC_PARTITIONS)),\
 $(if $(filter true,$(call has-partition,system_ext)),\
  $(FSTAB_DYNAMIC_SYSTEM_EXT),\
  $(FSTAB_DYNAMIC)),\
 $(FSTAB_LEGACY))$(if $(filter true,$(call device-has-characteristic,ufs)),_ufs).$(FSTAB_SUFFIX)\
)
endef
