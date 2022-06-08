How-to
---

## Create from scratch

Follow instructions in tart's repo to create from scratch: https://github.com/cirruslabs/tart/blob/main/README.md#creating-from-scratch

Example:

```bash
tart create --from-ipsw="$HOME/Downloads/UniversalMac_12.4_21F79_Restore.ipsw" --disk-size=64 macos
```

Then we need to manually setup the vanilla image with:

* Username: admin
* Password: admin
* Enable Auto-Login. Users & Groups -> Login Options -> Automatic login -> admin.
* Allow SSH. Sharing -> Remote Login
* Disable Lock Screen. Preferences -> Lock Screen -> disable "Require Password" after 5.
* Disable Screen Saver.
* Run `sudo visudo` in Terminal, find `%admin ALL=(ALL) ALL` add `admin ALL=(ALL) NOPASSWD: ALL` to allow sudo without a password.

## Create macOS base images

1 Make sure you have `packer` installed
2 Run `packer init base.pkr.hcl` to install tart's plugin for `packer`

### Base image

```bash
packer build templates/base.pkr.hcl
```

### Xcode image

First, download Xcode xip file.

Then, run the `packer` command to build Xcode image. For example:

```bash
packer build -var xcode_file=$HOME/Downloads/Xcode_13.4.1.xip templates/xcode.pkr.hcl
```

### Flutter image

```bash
packer build templates/flutter.pkr.hcl
```