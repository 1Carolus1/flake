{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ../../common
    ../../common/optional/nvidia-gpu.nix
  ];
}
