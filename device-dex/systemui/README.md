`CarSystemUI.apk` is the stock SystemUI image pulled from the tablet on 2026-09-29.
SHA-256 `36b33d0ed9710beddec2393945397f0623d439092009a8c7ded6fb83ba2c483a`.
Path on device: `/system/priv-app/CarSystemUI/CarSystemUI.apk`.

The `smali/` and `src/` trees are classes that agent sessions patched directly inside `classes2.dex`.
Those patches are not inside this APK.

`smali/` is the dex form. `src/` is the matching Java where the repo has it.

- `CarSysuiScalableHeaderController` — HVAC pill clamp (17.5–32.5) and half-degree labels. This smali is the splice that was packed into a SystemUI APK. ART rejected that dex (`debug_info_item` string index), so it was not left installed.
- `CarVhalSubscriptionHelper` — `setFloatProperty` catches a rejected write and logs `Rejected float write` instead of crashing. Same splice as the header class.
- `CarSysuiScalableFooterController` — home and app-grid behavior edited in an earlier dex session. The edited smali under `/tmp/rro` is gone; this copy is the disassembly of the SystemUI image from that work. The Java in `src/` is the source copy.
- `NightModeToggle` — present in the disassembled SystemUI image from the night-mode dex session. There is no Java file for it in this repo.
