{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/92888c12688792ca9c6f67eb8e6d33fa1753bfdd"; # awscli2 build fail, switch back to nixos-unstable when fixed
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-flake.url = "github:srid/nixos-flake";
    nur.url = github:nix-community/NUR;

    nixGL = {
      url = "github:nix-community/nixGL/def00794f963f51ccdcf19a512006bd7f9c78970";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv.url = "github:cachix/devenv";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      imports = [
        inputs.nixos-flake.flakeModule
        inputs.devenv.flakeModule
      ];

      perSystem = { pkgs, ... }:
        let
          myUserName = "ibecker";
          nixGLPlatform = inputs.nixGL.packages."${pkgs.system}".nixGLIntel;
          nixGLBinPath = "${nixGLPlatform}/bin";
          nixGLBinName = builtins.head (builtins.attrNames (builtins.readDir nixGLBinPath));
          nixGLPrefix = "${nixGLBinPath}/${nixGLBinName}";
        in
        {
          legacyPackages.homeConfigurations.${myUserName} =
            self.nixos-flake.lib.mkHomeConfiguration
              pkgs
              ({ pkgs, ... }: {
                imports = [
                  self.homeModules.default
                  inputs.catppuccin.homeManagerModules.catppuccin
                  inputs.nur.hmModules.nur
                  (builtins.fetchurl {
                    url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
                    sha256 = "f14874544414b9f6b068cfb8c19d2054825b8531f827ec292c2b0ecc5376b305";
                  })
                ];
                home.username = myUserName;
                home.homeDirectory = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/${myUserName}";
                home.stateVersion = "24.11";

                nixGL.prefix = nixGLPrefix;
              });

          devenv.shells.default = {
            name = "home";
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

            home.packages = with pkgs; [
              (config.lib.nixGL.wrap kooha)
            ];

            programs = {
              kitty = {
                package = (config.lib.nixGL.wrap pkgs.kitty);
              };
              firefox = {
                package = (config.lib.nixGL.wrap pkgs.firefox);
              };
              vscode = {
                package = (config.lib.nixGL.wrap pkgs.vscode);
              };
            };
          };
      };
    };
}
