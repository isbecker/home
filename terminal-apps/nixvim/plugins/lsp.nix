{ pkgs, ... }:
let
  # sha256 = "13g3xq35by8z0bbivfn5k9hid1bl8nawp0zvyqfqjyifx7pxhn08"; # 0.10.8
  sha256 = "1gs354s0nd60qhcwwq3vmw21n45gy09bvsmz3a6k0b0ldrps1zr6"; # 0.11.1

  kcl-ls = pkgs.stdenv.mkDerivation rec {
    pname = "kcl-language-server";
    # version = "0.10.8";
    version = "0.11.1";
    src = builtins.fetchTarball {
      url = "https://github.com/kcl-lang/kcl/releases/download/v${version}/kclvm-v${version}-linux-amd64.tar.gz";
      sha256 = sha256;
    };
    installPhase = ''
      mkdir -p $out/bin
      install -m755 bin/kcl-language-server $out/bin/kcl-language-server
    '';
  };
in
{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      servers = {
        yamlls.enable = true;
        jsonls.enable = true;
        nil_ls.enable = true;
        taplo.enable = true;
        ts_ls.enable = true;
        ruff.enable = true;
        dockerls.enable = true;
        ansiblels.enable = true;
        terraformls.enable = true;
        html.enable = true;
        gitlab_ci_ls.enable = true;
        fish_lsp.enable = true;
        marksman.enable = true; # markdown
        helm_ls = {
          enable = true;
          # filetypes = [
          #   "yaml"
          #   "yml"
          #   "tpl"
          # ];
        };
        kcl = {
          enable = true;
          package = kcl-ls;
          filetypes = [
            "kcl"
            "k"
          ];
        };
      };

      keymaps = {
        # See :h lsp-buf
        lspBuf = {
          K = {
            action = "hover";
            desc = "Show documentation";
          };
          gd = {
            action = "definition";
            desc = "Goto definition";
          };
          gD = {
            action = "declaration";
            desc = "Goto declaration";
          };
          gi = {
            action = "implementation";
            desc = "Goto implementation";
          };
          gt = {
            # FIXME conflicts with "next tab page" :h gt
            action = "type_definition";
            desc = "Goto type definition";
          };
          ga = {
            action = "code_action";
            desc = "Show code actions";
          };
          "g*" = {
            action = "document_symbol";
            desc = "Show document symbols";
          };
          "<leader>rn" = {
            action = "rename";
            desc = "Rename symbol";
          };
        };
      };
    };
  };
}
