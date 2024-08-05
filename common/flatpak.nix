{ inputs, ... }: {
  imports = [ ];

  # xdg.portal.enable = true;
  services.flatpak.enable = true;

  home-manager = {
    sharedModules = [
      inputs.flatpaks.homeManagerModules.declarative-flatpak
    ];

    users.carolus = {
      services.flatpak = {
        remotes = {
          "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        };
        packages = [
          "flathub:app/dev.geopjr.Collision/x86_64/stable"
          "flathub:app/com.vysp3r.ProtonPlus/x86_64/stable"
        ];
      };
    };
  };
}
