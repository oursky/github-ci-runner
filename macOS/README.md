## Requirement

- macOS 12
- aria2
- jdupe
- Apple Developer account

## Preparation

- Download from Developer Downloads:
  - [Command Line Tools 13.4](https://download.developer.apple.com/Developer_Tools/Command_Line_Tools_for_Xcode_13.4/Command_Line_Tools_for_Xcode_13.4.dmg)
    - extract as `macOS/volumes/setup/assets/CommandLineTools_13.4.pkg`
  - Xcode xips
    - refer to `macOS/volumes/xcodes/xips/.gitignore` for required versions

## Build steps

1. Run `make ipsw` to fetch IPSW
   - `aria2` is used to download IPSW
   - If already have IPSW, skip it by putting it as `macOS/images/macOS.ipsw`
2. Run `make vanilla` to make vanilla image
3. Run `make base` to make base image
4. Run `make -C volumes xcodes.dmg` to make Xcode volume
  - Ensure Xcode xips are prepared as mentioned above
  - `jdupe` is used to optimize volume size, need much time
5. Run `make runner` to make runner image
  - Ensure Command Line Tools are prepared as mentioned above
6. Run `make -C volumes runner.dmg` to make runner volume
7. Or just `make vanilla base runner`

## Run VM Coordinator

1. Prepare `runner-1.json` from `runner-template.json`
2. Run `bin/coordinator -config runner-1.json`