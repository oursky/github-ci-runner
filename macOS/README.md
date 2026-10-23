## Requirement

- macOS 12
- aria2
- jq
- xcodes
- jdupes
- Apple Developer account

## Preparation

- Run `make xips XCODE_VERSIONS="26 27"` to download Xcode xips to `macOS/build/xips`
  - A prefix such as `26` or `26.6` selects the newest matching release, from https://xcodereleases.com
  - `xcodes` asks for your Apple ID on first use
  - Or download xips from Developer Downloads and put them in `macOS/build/xips` as `Xcode_<version>.xip`

## Build steps

1. Run `make ipsw` to fetch IPSW
   - `aria2` is used to download IPSW
   - By default, it fetches the newest IPSW that the host supports
   - To fetch another version, set `MACOS_VERSION`, for example `make ipsw MACOS_VERSION=26`
     - A prefix such as `26` or `26.6` selects the newest matching release, from https://ipsw.me/VirtualMac2,1
   - If already have IPSW, skip it by putting it as `build/assets/macOS.ipsw`
2. Run `make vanilla` to make vanilla image
3. Run `make base` to make base image
4. Run `make xcodes` to make Xcode volume
  - Ensure Xcode xips are prepared as mentioned above
  - `jdupes` is used to optimize volume size, need much time
5. Run `make runner` to make runner image

Or just `make vanilla base xcodes runner`

## Share the runner image

1. Run `make archive` to pack the deploy artifacts into `build/runner-image.aar`
2. On the other host, run `aa extract -i runner-image.aar -d build` in `macOS/`

## Run VM Coordinator

1. Prepare `coordinator.json` from `coordinator-template.json`
2. Run `bin/coordinator -config coordinator.json`
