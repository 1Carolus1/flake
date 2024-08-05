{ pkgs, ... }:
{
  virtualisation.containers.enable = true;
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    lazydocker # status of containers in the terminal
    docker-compose # start group of containers for dev

    quickemu # QEMU with downloader and one command starter
    quickgui # GUI for quickget and quickemu
  ];

  virtualisation.waydroid.enable = true;
}
