# OEM Scalable UI demonstration — add to device/<oem>/<product>/device.mk
#
# $(call inherit-product, vendor/aospstack/ScalableUI/oem_demo_packages.mk)

# Tip demo (prebuilt-safe) — recommended default
# StubCarLauncher is the AOSP HOME visibility barrier
# (packages/services/Car/car_product/dewd/apps/StubCarLauncher).
# HOME resolves to com.android.car.stub.launcher/.StubHome so boot and user
# switch do not start stock CarLauncher maps and cards.
# TODO(b/432217693): drop this once a dedicated visibility barrier exists.
# CarLauncher stays for AppGridActivity and ControlBarActivity.
PRODUCT_PACKAGES += \
    CarSystemUI \
    CarLauncher \
    StubCarLauncher \
    MockWidgets \
    MultiPanelLandscapeRRO \
    CarLauncherMultiPanelRRO \
    CarSystemUIScalableUIOverlay \
    privapp-permissions-mockwidgets.xml

# Unified OEM overlay package (tip panels by default; Pleos optional)
PRODUCT_PACKAGES += \
    OemDemoRRO \
    CarSysuiScalableBarControllers

# Optional Pleos-only bars overlay (when Controllers linked into CarSystemUI)
