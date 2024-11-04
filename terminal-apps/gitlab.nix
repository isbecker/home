{ pkgs, lib, ... }:
let
  gitlabCli = pkgs.stdenv.mkDerivation rec {
    pname = "gitlab-cli";
    version = "1.48.0";
    src = builtins.fetchTarball {
      url = "https://gitlab.com/gitlab-org/cli/-/releases/v${version}/downloads/glab_${version}_linux_amd64.tar.gz";
      sha256 = "19sv6msgg1pkii8zdql9hfn7281qijyr2a1jz393gw94af0f7r6j";
    };
    installPhase = ''
      mkdir -p $out/bin
      install -m755 glab $out/bin/glab
    '';

    postInstall = lib.optionalString (pkgs.stdenv.hostPlatform == pkgs.stdenv.buildPlatform) ''
      installShellCompletion --cmd glab \
        --bash <($out/bin/glab completion bash) \
        --fish <($out/bin/glab completion fish) \
        --zsh <($out/bin/glab completion zsh)
    '';
  };
in
{
  home.packages = [
    gitlabCli
  ];
}
