{ inputs, pkgs, ... }: {
  services = {
    xserver.enable = true;
    displayManager = {
      sddm = {
        enable = true;
        autoNumlock = true;
        wayland.enable = true;
      };
      defaultSession = "plasma";
    };
    desktopManager.plasma6.enable = true;
  };

  programs.kdeconnect.enable = true;
  programs.kclock.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
  ];

  environment.systemPackages = with pkgs; [
    krename
    kdePackages.kalk
    kdePackages.plasma-browser-integration
  ];

  users.users =
    {
      carolus = {
        packages = with pkgs; [
          (catppuccin-kde.override {
            flavour = [ "mocha" ];
            accents = [ "green" ];
          })
          (catppuccin-papirus-folders.override {
            flavor = "mocha";
            accent = "green";
          })
          catppuccin-cursors.mochaGreen
        ];
      };
    };

  home-manager = {
    sharedModules = [
      inputs.plasma-manager.homeManagerModules.plasma-manager
    ];

    users.carolus = {
      programs.plasma = {
        enable = true;
        overrideConfig = true;
        workspace = {
          clickItemTo = "select";
          theme = "catpuccin-mocha-green";
          lookAndFeel = "Catppuccin-Mocha-Green";
          colorScheme = "CatpuccinMochaGreen";
          iconTheme = "Papirus-Dark";
          cursor.theme = "catppuccin-mocha-green-cursors";
          # wallpaperSlideShow.path = ../assets/wallpapers;
        };

        kwin.titlebarButtons = {
          left = [ "on-all-desktops" "keep-above-windows" ];
          right = [ "minimize" "maximize" "close" ];
        };

        configFile.kcminputrc.Keyboard.NumLock.value = 0;
        configFile.kwinrc.Effect-overview.BorderActivate = 9;
        configFile.kwinrc.EdgeBarrier.EdgeBarrier = 0;

        powerdevil.AC.autoSuspend.action = "nothing"; # When charging or when Desktop, no sleep

        panels = [
          {
            screen = 0;
            location = "bottom";
            height = 40;
            floating = false;
            hiding = "normalpanel";
            widgets = [
              {
                name = "org.kde.plasma.kickoff";
                config = {
                  General.icon = "nix-snowflake";
                };
              }
              {
                name = "org.kde.plasma.icontasks";
                config = {
                  General.launchers = [
                    "applications:org.kde.konsole.desktop"
                    "applications:org.kde.dolphin.desktop"
                    "applications:spotify.desktop"
                    "applications:vesktop.desktop"
                    "applications:code-url-handler.desktop"
                    "applications:steam.desktop"
                  ];
                };
              }
              {
                name = "com.github.k-donn.plasmoid-wunderground";
                config = {
                  Station.stationID = "KMIWYOMI37";
                };
              }
              "org.kde.plasma.marginsseparator"
              "org.kde.plasma.systemtray"
              "org.kde.plasma.digitalclock"
            ];
          }
        ];
      };
      programs.konsole = {
        enable = true;
        defaultProfile = "Catppuccin";
        profiles.catppuccin = {
          name = "Catppuccin";
          colorScheme = "Catppuccin-Mocha";
        };
      };
      xdg.dataFile."konsole/Catppuccin-Mocha.colorscheme".source =
        pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "konsole";
            rev = "7d86b8a1e56e58f6b5649cdaac543a573ac194ca";
            sha256 = "EwSJMTxnaj2UlNJm1t6znnatfzgm1awIQQUF3VPfCTM=";
          }
        + "/Catppuccin-Mocha.colorscheme";
      xdg.dataFile."kio/servicemenus/krename.desktop".text = ''
        [Desktop Entry]
        Type=Service
        ServiceTypes=KonqPopupMenu/Plugin
        MimeType=all/all
        Actions=rename;
        X-KDE-Priority=TopLevel
        X-KDE-StartupNotify=false
        Icon=krename

        [Desktop Action rename]
        Name=Advanced Rename
        Name[it]=Rinomina: opzioni avanzate
        Icon=edit-rename
        Exec=krename %F
      '';
      xdg.dataFile."kio/servicemenus/openinvscode.desktop".text = ''
        [Desktop Entry]
        Name = Open In VScode
        Type=Service
        ServiceTypes=KonqPopupMenu/Plugin
        MimeType=all/all;
        X-KDE-Priority=TopLevel
        Actions = openvscode

        [Desktop Action openvscode]
        Name = Open In VSCode
        Exec=code %f
        Icon=visual-studio-code
      '';
    };
  };
}
