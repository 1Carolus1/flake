{ inputs, pkgs, config, ... }: {
  home-manager = {
    users.carolus = {
      programs.git = {
        enable = true;
        package = pkgs.gitFull;

        userName = "1carolus1";
        userEmail = "carolus@auctioneersoftware.com";

        lfs.enable = true;

        extraConfig = {
          init.defaultBranch = "main";

          # Thanks Scrumplex for showing me this from Scott! https://www.youtube.com/watch?v=aolI_Rz0ZqY
          rerere.enabled = true;
          core.fsmonitor = true;
        };
      };

      programs.vscode = {
        enable = true;
        package = pkgs.vscode.fhsWithPackages (ps: with ps; [ ]);
      };
    };
  };

  environment.systemPackages = with pkgs; [
    nil
    nixpkgs-fmt

    nixpkgs-review
    # (writeScriptBin "nixpkgs-review" ''
    #   #!/usr/bin/env bash

    #   export GITHUB_TOKEN=$(cat ${config.age.secrets."aki-nixpkgs-review-github-token".path})
    #   exec ${pkgs.nixpkgs-review}/bin/nixpkgs-review "$@"
    # '')

    nodejs-18_x

    python311
  ];
}
