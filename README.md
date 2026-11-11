# AnchorChain

### [Read the user guide and documentation here.](https://seapower-modders.github.io/AnchorChain/)

# Beta-compatible fork

This fork combines upstream pull requests #20 and #24 (by @struckl) so that AnchorChain loads on the Sea Power Public Beta (3D globe map) as well as the current release, and fixes `ACIncompatibility` removing plugins whose incompatible mod is not installed.

- `AnchorChain.dll` 1.2.0: Workshop content. Waits for the game's mod folders, loads `[ACConfig]` plugins on both game versions.
- `AnchorChain.Preloader.dll` 2.0.0: thin stub, installed by hand once (extract `ACPreloader-2.0.0.zip` into the Sea Power folder, replacing the old preloader). It reads no game types, so later fixes ship through the Workshop item.
- Build and package with `scripts\Package.ps1`. Game assemblies are copied into `Dll\` (git-ignored) from `Sea Power_Data\Managed`.

# Included Software

This program's release files contain the umodified program BepInEx, licensed under LGPL v2.1. The source code is available here: https://github.com/BepInEx/BepInEx.
