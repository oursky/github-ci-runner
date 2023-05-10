## Requirement

- macOS 12
- aria2
- jdupe
- Apple Developer account

## Preparation

- Download from Developer Downloads:
  - Xcode xips
    - put xips in `macOS/build/xips`

## Build steps

1. Run `make ipsw` to fetch IPSW
   - `aria2` is used to download IPSW
   - If already have IPSW, skip it by putting it as `macOS/images/macOS.ipsw`
2. Run `make vanilla` to make vanilla image
3. Run `make base` to make base image
4. Run `make xcodes` to make Xcode volume
  - Ensure Xcode xips are prepared as mentioned above
  - `jdupe` is used to optimize volume size, need much time
5. Run `make runner` to make runner image

Or just `make vanilla base xcodes runner`

## Run VM Coordinator

1. Prepare `coordinator.json` from `coordinator-template.json`
2. Run `bin/coordinator -config coordinator.json`