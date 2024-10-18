{ pkgs, lib, ... }:
let
  gitlabCli = pkgs.stdenv.mkDerivation rec {
    pname = "gitlab-cli";
    version = "1.48.0";
    src = builtins.fetchTarball {
      url = "https://gitlab.com/gitlab-org/cli/-/releases/v${version}/downloads/glab_${version}_linux_amd64.tar.gz";
      sha256 = "1q2k87xf8swgmj7gskhvmjs8ifb2pwlv7v0ymc3zhckil7brj9zx";
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
