{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/5d5367eb9d9cbae4b22d375a5f9b378a030e64fd";
    #"/92888c12688792ca9c6f67eb8e6d33fa1753bfdd"; # awscli2 build fail, switch back to nixos-unstable when fixed
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
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    # nix-snapshotter = {
    #   url = "github:isbecker/nix-snapshotter"; #5f7eae246a96b96c29f96bbab8f1fbcf51731c92";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
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

      perSystem = { pkgs, ... }:
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
                  inputs.nur.hmModules.nur
                  inputs.nixvim.homeManagerModules.nixvim
                  # inputs.nix-snapshotter.homeModules.default
                ];
                home.username = myUserName;
                home.homeDirectory = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/${myUserName}";
                home.stateVersion = "24.11";

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
            };
          };
      };
    };
}
