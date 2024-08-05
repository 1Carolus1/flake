{ pkgs, ... }: {
  hardware.sane.enable = true;
  services.printing.enable = true;
  hardware.sane.extraBackends = with pkgs; [ sane-airscan hplipWithPlugin samsung-unified-linux-driver ];
  services.printing.drivers = with pkgs; [ sane-airscan hplipWithPlugin samsung-unified-linux-driver ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
