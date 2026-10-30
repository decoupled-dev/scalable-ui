# Scalable UI launcher — add to device/<oem>/<product>/device.mk
#
# $(call inherit-product, vendor/<oem>/ScalableUI/scalableui_packages.mk)
#
# CarSystemUI must also link CarSysuiScalableBarControllers; see integration/.
#
# StubCarLauncher is the AOSP HOME visibility barrier
# (packages/services/Car/car_product/dewd/apps/StubCarLauncher). HOME resolves
# to com.android.car.stub.launcher/.StubHome, parked off-screen by
# LauncherRRO's home_panel, so boot and user switch do not paint stock
# CarLauncher over the map. CarLauncher stays for AppGridActivity.
PRODUCT_PACKAGES += \
    CarSystemUI \
    CarLauncher \
    StubCarLauncher \
    CarSysuiScalableBarControllers \
    LauncherRRO \
    CarLauncherThemeRRO
