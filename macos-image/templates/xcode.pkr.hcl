packer {
  required_plugins {
    tart = {
      version = ">= 0.3.1"
      source  = "github.com/cirruslabs/tart"
    }
  }
}

variable "xcode_file" {
  type =  string
  default = env("XCODE_FILE")
}

variable "xcode_version" {
  type =  string
  default = "13.4.1"
}

source "tart-cli" "tart" {
  vm_base_name = "macos-base"
  vm_name      = "macos-xcode:${var.xcode_version}"
  cpu_count    = 4
  memory_gb    = 8
  disk_size_gb = 128
  ssh_password = "admin"
  ssh_username = "admin"
  ssh_timeout  = "120s"
}

build {
  sources = ["source.tart-cli.tart"]

  provisioner "shell" {
    inline = [
      "source ~/.zprofile",
      "brew --version",
      "brew update",
      "brew upgrade",
      "brew install curl wget unzip zip ca-certificates cocoapods blackbox node",
      "npm i -g appcenter-cli",
      "sudo softwareupdate --install-rosetta --agree-to-license",
    ]
  }

  provisioner "file" {
    source = "${var.xcode_file}"
    destination = "$PWD/Xcode.xip"
  }

  provisioner "shell" {
    inline = [
      "echo 'export PATH=/usr/local/bin/:$PATH' >> ~/.zprofile",
      "source ~/.zprofile",
      "wget --quiet https://github.com/RobotsAndPencils/xcodes/releases/latest/download/xcodes.zip",
      "unzip xcodes.zip",
      "rm xcodes.zip",
      "chmod +x xcodes",
      "sudo mkdir -p /usr/local/bin/",
      "sudo mv xcodes /usr/local/bin/xcodes",
      "xcodes version",
      "xcodes install ${var.xcode_version} --experimental-unxip --path $PWD/Xcode.xip",
      "sudo rm -rf ~/.Trash/*",
      "xcodes select ${var.xcode_version}",
      "sudo xcodebuild -runFirstLaunch",
      "wget https://www.apple.com/certificateauthority/AppleWWDRCAG3.cer",
      "sudo security authorizationdb write com.apple.trust-settings.admin allow",
      "security add-trusted-cert -d -r unspecified -k ~/Library/Keychains/login.keychain-db AppleWWDRCAG3.cer",
      "rm -f AppleWWDRCAG3.cer",
    ]
  }
}
