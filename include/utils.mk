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
