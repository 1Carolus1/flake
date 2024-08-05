{ inputs, pkgs, ... }: {
  system.userActivationScripts = {
    removeConflictingFiles = {
      text = ''
        for dir in /home/*; do
          if [ -d "$dir" ]; then
            FILE_PATH="$dir/.gtkrc-2.0.backup"
            if [ -e "$FILE_PATH" ]; then
              rm -f "$FILE_PATH"
              echo "File $FILE_PATH has been deleted."
            fi

            FILE_PATH="$dir/.config/gtk-4.0/gtk.css.backup"
            if [ -e "$FILE_PATH" ]; then
              rm -f "$FILE_PATH"
              echo "File $FILE_PATH has been deleted."
            fi
          fi
        done
      '';
    };
  };

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [
      inputs.catppuccin.homeManagerModules.catppuccin
    ];

    users.carolus = {
      home.stateVersion = "24.05";

      xdg.mimeApps = {
        enable = true;
        associations.added = {
          "application/x-extension-htm" = "google-chrome.desktop";
          "application/x-extension-html" = "google-chrome.desktop";
          "application/x-extension-shtml" = "google-chrome.desktop";
          "application/x-extension-xht" = "google-chrome.desktop";
          "application/x-extension-xhtml" = "google-chrome.desktop";
          "application/xhtml+xml" = "google-chrome.desktop";
          "text/html" = "google-chrome.desktop";
          "x-scheme-handler/google-chrome" = "google-chrome.desktop";
          "x-scheme-handler/http" = "google-chrome.desktop";
          "x-scheme-handler/https" = "google-chrome.desktop";
          "video/mp4" = "vlc.desktop";
          "model/stl" = "com.ultimaker.cura.desktop";
          "text/x.gcode" = "com.ultimaker.cura.desktop";
          "application/x-shellscript" = "code.desktop";
          "application/vhd.microsoft.portable-executable" = "wine.desktop";
        };
        defaultApplications = {
          "application/x-ms-dos-executable" = "wine.desktop";
          "application/x-msi" = "wine.desktop";
          "application/x-ms-shortcut" = "wine.desktop";
          "application/x-bat" = "wine.desktop";
          "application/x-mswinurl" = "wine.desktop";
          "application/vhd.microsoft.portable-executable" = "wine.desktop";
          "application/x-extension-htm" = "google-chrome.desktop";
          "application/x-extension-html" = "google-chrome.desktop";
          "application/x-extension-shtml" = "google-chrome.desktop";
          "application/x-extension-xht" = "google-chrome.desktop";
          "application/x-extension-xhtml" = "google-chrome.desktop";
          "text/html" = "google-chrome.desktop";
          "application/xhtml+xml" = "google-chrome.desktop";
          "x-scheme-handler/google-chrome" = "google-chrome.desktop";
          "x-scheme-handler/http" = "google-chrome.desktop";
          "x-scheme-handler/https" = "google-chrome.desktop";
          "model/stl" = "com.ultimaker.cura.desktop";
          "text/x.gcode" = "com.ultimaker.cura.desktop";
          "x-scheme-handler/ror2mm" = "r2modman.desktop";
          "image/svg+xml" = "code.desktop";
          "application/json" = "code.desktop";
          "application/xml" = "code.desktop";
          "application/yaml" = "code.desktop";
          "application/toml" = "code.desktop";
          "application/x-shellscript" = "code.desktop";
          "text/x-python" = "code.desktop";
          "text/rust" = "code.desktop";
          "text/javascript" = "code.desktop";
          "text/css" = "code.desktop";
          "text/x-cmake" = "code.desktop";
          "text/x-c++src" = "code.desktop";
          "text/x-c++hdr" = "code.desktop";
          "text/x-systemd-unit" = "code.desktop";
          "text/markdown" = "code.desktop";
          "text/plain" = "code.desktop";
          "x-scheme-handler/bitwarden" = "Bitwarden.desktop";
          "x-scheme-handler/beatsaver" = "BeatSaberModManager-url-beatsaver.desktop";
          "x-scheme-handler/bsplaylist" = "BeatSaberModManager-url-bsplaylist.desktop";
          "x-scheme-handler/modelsaber" = "BeatSaberModManager-url-modelsaber.desktop";
          "application/x-modrinth-modpack+zip" = "org.prismlauncher.PrismLauncher.desktop";
          "x-scheme-handler/curseforge" = "org.prismlauncher.PrismLauncher.desktop";
        };
      };

      catppuccin.enable = true;
      catppuccin.flavor = "mocha";
      catppuccin.accent = "green";

      gtk = {
        enable = true;
        gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
        gtk4.extraConfig = { gtk-application-prefer-dark-theme = true; };
        theme = {
          name = "catppuccin-mocha-green-standard";
          package = (pkgs.catppuccin-gtk.override {
            variant = "mocha";
            accents = [ "green" ];
          });
        };
      };

      programs = {
        hyfetch = {
          enable = true;
          settings = {
            preset = "burger";
            mode = "rgb";
            light_dark = "dark";
            lightness = 0.65;
            color_align = {
              mode = "horizontal";
              custom_colors = [ ];
              fore_back = null;
            };
            backend = "fastfetch";
            distro = null;
            pride_month_shown = [ ];
          };
        };
        starship = {
          enable = true;
          enableBashIntegration = true;
          settings = {
            directory = {
              truncation_length = 12;
              truncate_to_repo = false;
              truncation_symbol = "…/";
            };
          };
        };
        zoxide = {
          enable = true;
          enableBashIntegration = true;
          options = [
            "--cmd cd"
          ];
        };
        bash = {
          enable = true;
          bashrcExtra = ''
            if [ -n "$PS1" ]; then
                # Run hyfetch if the shell is interactive
                hyfetch
            fi
          '';
        };
        tealdeer = {
          enable = true;
          settings.updates = {
            auto_update = true;
            auto_update_interval_hours = 24;
          };
        };
        bat.enable = true;
        bottom.enable = true;
      };
      xdg.configFile."autostart/vesktop.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Name=Vesktop
        Comment=Vesktop autostart script
        Exec=vesktop
        StartupNotify=false
        Terminal=false
      '';
      # xdg.configFile."autostart/openrgb.desktop".text = ''
      #   [Desktop Entry]
      #   Type=Application
      #   Name=OpenRGB
      #   Comment=OpenRGB autostart script
      #   Exec=openrgb --startminimized --profile Pink
      #   StartupNotify=false
      #   Terminal=false
      # '';
      home.file.".ssh/config" = {
        target = ".ssh/config_source";
        onChange = ''cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config'';
        text = ''
          Host *
              StrictHostKeyChecking accept-new
        '';
      };
    };
  };
}
