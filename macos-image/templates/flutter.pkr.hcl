packer {
  required_plugins {
    tart = {
      version = ">= 0.3.1"
      source  = "github.com/cirruslabs/tart"
    }
  }
}

variable "xcode_version" {
  type =  string
  default = "13.4.1"
}

variable "flutter_version" {
  type =  string
  default = "3.0.1-stable"
}

source "tart-cli" "tart" {
  vm_base_name = "macos-xcode:${var.xcode_version}"
  vm_name      = "macos-flutter:${var.flutter_version}"
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
      "echo 'export FLUTTER_HOME=$HOME/.local' >> ~/.zprofile",
      "echo 'export PATH=$FLUTTER_HOME/flutter:$FLUTTER_HOME/flutter/bin/:$FLUTTER_HOME/flutter/bin/cache/dart-sdk/bin:$PATH' >> ~/.zprofile",
      "source ~/.zprofile",
      "mkdir -p $FLUTTER_HOME",
      "cd $FLUTTER_HOME",
      "wget --quiet https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_${var.flutter_version}.zip -O flutter.zip",
      "unzip -q flutter.zip",
      "flutter doctor",
      "flutter precache --ios",
      "rm -f flutter.zip",
    ]
  }
}
