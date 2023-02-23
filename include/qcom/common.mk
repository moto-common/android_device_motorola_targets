# QTI Components
TARGET_COMMON_QTI_COMPONENTS := \
    adreno \
    audio \
    av \
    charging \
    display \
    dsprpcd \
    init \
    keymaster \
    media \
    neuralnetworks \
    overlay \
    qseecomd \
    vibrator \
    wlan

# QCOM Common Hook
include device/qcom/common/common.mk

# Moto-Common QCOM Hook
$(call inherit-product, device/motorola/common/hardware/qcom/common.mk)
