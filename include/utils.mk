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

# $(call is-kernel-greater-than-or-equal-to,kernel-version)
# Checks if the target kernel version is greater than or equal to
# the specified version.
#
# How it works:
#  1. $(shell expr $(TARGET_KERNEL_VERSION) \>= $(1)) compares
#     the target kernel version with the specified version using
#     the "expr" command.
#  2. The result of the comparison is passed to the "filter"
#     function, which returns "1" if the comparison is true and
#     "0" otherwise.
#  3. $(if $(filter 1,...),true,false) returns "true" if the
#     comparison is true and "false" otherwise.

define is-kernel-greater-than-or-equal-to
$(if $(filter 1,$(shell expr $(TARGET_KERNEL_VERSION) \>= $(1))),true,false)
endef
