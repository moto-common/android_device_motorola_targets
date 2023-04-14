#!/bin/bash

# Run as follows, from root of rom ./device/motorola/targets/scripts/remove_conflicting_repos.sh

echo "Removing Conflicting Repo's...'"
echo ""

rm -rf vendor/qcom/opensource/data-ipa-cfg-mgr-legacy-um
rm -rf hardware/qcom-caf/thermal
rm -rf vendor/qcom/opensource/audio-hal

echo ""
echo "Conflicting Repo's Removed"
echo ""
echo "PRESS ENTER TO EXIT"
