{ pkgs, lib, ... }:
let
  gitlabCli = pkgs.stdenv.mkDerivation rec {
    pname = "gitlab-cli";
    version = "1.46.1";
    src = builtins.fetchTarball {
      url = "https://gitlab.com/gitlab-org/cli/-/releases/v${version}/downloads/glab_${version}_Linux_x86_64.tar.gz";
      sha256 = "1ncnabrb36izrmlarpgdgf7lzdc07gkrm2abh54j9h0fg5h6nrin";
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
