{ inputs, pkgs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  programs.nix-ld.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.libinput.touchpad.tapping = true;

  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.fstrim.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Electron Apps in Wayland

  users.mutableUsers = true;
  users.users = {
    carolus = {
      isNormalUser = true;
      description = "oooga booga";
      uid = 1000;
      extraGroups = [ "networkmanager" "wheel" "plugdev" "scanner" "lp" "docker" ];
    };
  };

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "pink";

  environment.systemPackages = with pkgs; [
    fuse
    sshfs
    sshpass
    fastfetch
    hyfetch
    pciutils
    fira-code
    fira-code-nerdfont
    starship
    fd
    ripgrep
    bat
    bottom
    tealdeer
    wget
    curl
    zoxide
    vdhcoapp
    # gnupg
    git
    nano
    # torrenttools
    gparted
    usbimager
    baobab
    angryipscanner
    obs-studio
    vlc
    kdePackages.kdenlive
    bitwarden
    vesktop
    tor-browser
    google-chrome
    chromium
    spotify
    jellyfin-media-player
    onlyoffice-bin
    simple-scan
    pdfarranger
    handbrake
    slack
  ];

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [ "--verbose" ];
    dates = "daily";
    operation = "boot";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "24.05";
}
