{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    # nixpkgs.url = "github:nixos/nixpkgs/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    # nixpkgs.url = "github:nixos/nixpkgs/6fe896e3159c87084e322d68909a0f1d0f4b13ed";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    nixos-unified = {
      url = "github:srid/nixos-unified";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gl-host.url = "github:numtide/nix-gl-host";

    catppuccin = {
      url = "github:catppuccin/nix";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vim-autoread = {
      flake = false;
      url = "github:djoshea/vim-autoread/24061f84652d768bfb85d222c88580b3af138dab";
    };
    # nix-snapshotter = {
    #   url = "github:isbecker/nix-snapshotter"; #5f7eae246a96b96c29f96bbab8f1fbcf51731c92";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    gigarandr = {
      url = "github:isbecker/gigarandr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
    experimental-features = "nix-command flakes impure-derivations";
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];

      imports = [
        inputs.nixos-unified.flakeModule
        inputs.devenv.flakeModule
      ];

      perSystem = { pkgs, system, ... }:
        let
          myUserName = "ibecker";
        in
        {
          legacyPackages.homeConfigurations.${myUserName} =
            self.nixos-unified.lib.mkHomeConfiguration
              pkgs
              ({ pkgs, ... }: {
                imports = [
                  self.homeModules.default
                  inputs.catppuccin.homeManagerModules.catppuccin
                  inputs.nur.modules.homeManager.default
                  inputs.nixvim.homeManagerModules.nixvim
                  # inputs.nix-snapshotter.homeModules.default
                ];
                home.username = myUserName;
                home.homeDirectory = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/${myUserName}";
                home.stateVersion = "25.05";

                systemd.user.startServices = "sd-switch";
              });

          devenv.shells.default = {
            name = "home";
            enterShell = ''
              echo "                  __- -                       ";
              echo "                 (                            ";
              echo "                _))_                          ";
              echo "                |  |________                  ";
              echo "       .------------   |    -----------.      ";
              echo "      /.^.\  Welcome   |            /.^.\     ";
              echo "     /.   .\           |  Home     /.   .\    ";
              echo "    /.     .\          |          /.     .\   ";
              echo "   /.  ___ '.|__....---T---....__|.' ___  .\  ";
              echo "  |   |_|_|  |   _..   |   .-.   |  |_|_|  |  ";
              echo "  |   |_|_|  |  |  |   |   |_|   |  |_|_|  |  ";
              echo "  |__________|__|..+-------....__|_________|  ";
            '';

            pre-commit.hooks = {
              treefmt = {
                package = pkgs.treefmt2;
                enable = true;
                settings = {
                  formatters = [
                    pkgs.nixpkgs-fmt
                    pkgs.taplo # TOML - primarily just for the treefmt config files
                  ];
                };
              };
            };
          };
        };

      flake = {
        # All home-manager configurations are kept here.
        homeModules.default = { pkgs, config, ... }:
          {
            imports = [
              ./home.nix
            ];

            catppuccin = {
              enable = true;
              flavor = "macchiato";
            };

            nixGL = {
              packages = inputs.nixgl.packages;
              defaultWrapper = "mesa";
              offloadWrapper = "nvidiaPrime";
              installScripts = [
                "mesa"
                "mesaPrime"
                "nvidia"
                "nvidiaPrime"
              ];
            };
            home.packages = with pkgs; [
              python312Packages.setuptools
              inputs.nix-gl-host.defaultPackage.${system}
              nixVersions.latest
            ];
          };
      };
    };
}
