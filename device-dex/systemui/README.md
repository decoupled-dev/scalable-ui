`CarSystemUI.apk` is the stock SystemUI image pulled from the tablet on 2026-09-29.
SHA-256 `36b33d0ed9710beddec2393945397f0623d439092009a8c7ded6fb83ba2c483a`.
Path on device: `/system/priv-app/CarSystemUI/CarSystemUI.apk`.

The `smali/` and `src/` trees are classes that agent sessions patched directly inside `classes2.dex`.
Those patches are not inside this APK.

`smali/` is the dex form. `src/` is the matching Java where the repo has it.

- `CarSysuiScalableHeaderController` — disassembly of `classes5.dex` from the installed image (`assets/prebuilts/CarSystemUI.apk`, SHA-256 `04ae016a…`), patched on 2026-10-01 and left installed. Two edits over the previous image (`backups/CarSystemUI-20260930-1019.apk`):
  - `assignUniqueIds` returns right after `setId` when the view class name ends in `PrivacyChip`. The chip resolves its children by id in `setOnClickListener`; renumbering them threw `ID does not reference a View inside this View` and the camera/mic chip window was never shown.
  - `wireStatusPills` binds `qc_volume_panel` to `launcher_status_volume_slot` / `launcher_status_volume` (opens `android.settings.SOUND_SETTINGS` as fallback).
  Built with baksmali/smali 2.5.2 (`-a 35`), the dex stored uncompressed, zipaligned, platform-signed. `classes5.dex` holds only this controller and `CarVhalSubscriptionHelper`, so it can be swapped whole without touching `classes2.dex`. The matching Java lives in `systemui/CarSysuiScalableBarControllers`; the Java also collapses the chip spacer when no chip is visible (`syncPrivacySpacer`), which is not in the dex.
- `CarVhalSubscriptionHelper` — `setFloatProperty` catches a rejected write and logs `Rejected float write` instead of crashing. Same splice as the header class.
- `CarSysuiScalableFooterController` — home and app-grid behavior edited in an earlier dex session. The edited smali under `/tmp/rro` is gone; this copy is the disassembly of the SystemUI image from that work. The Java in `src/` is the source copy.
- `NightModeToggle` — present in the disassembled SystemUI image from the night-mode dex session. There is no Java file for it in this repo.
