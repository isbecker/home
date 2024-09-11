{ pkgs, lib, ... }:
let
  vcluster = pkgs.buildGoModule rec {
    pname = "vcluster";
    version = "0.20.0";

    src = pkgs.fetchFromGitHub {
      owner = "loft-sh";
      repo = "vcluster";
      rev = "v${version}";
      hash = "sha256-T6yHv5VB943eh+yXSwo32XhTCiPkPoZWvbSTSsh1TFg=";
    };

    vendorHash = null;

    subPackages = [ "cmd/vclusterctl" ];

    ldflags = [
      "-s"
      "-w"
      "-X main.version=${version}"
    ];

    nativeBuildInputs = [ pkgs.installShellFiles ];

    # Test is disabled because e2e tests expect k8s.
    doCheck = false;

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin
      install -Dm755 "$GOPATH/bin/vclusterctl" -T $out/bin/vcluster
      runHook postInstall
    '';

    # postInstall = lib.optionalString (pkgs.stdenv.hostPlatform == pkgs.stdenv.buildPlatform) ''
    #   installShellCompletion --cmd vcluster \
    #     --bash <($out/bin/vcluster completion bash) \
    #     --fish <($out/bin/vcluster completion fish) \
    #     --zsh <($out/bin/vcluster completion zsh)
    # '';

    meta = {
      changelog = "https://github.com/loft-sh/vcluster/releases/tag/v${version}";
      description = "Create fully functional virtual Kubernetes clusters";
      downloadPage = "https://github.com/loft-sh/vcluster";
      homepage = "https://www.vcluster.com/";
      license = lib.licenses.asl20;
      mainProgram = "vcluster";
    };
  };
in
{
  home.packages = [
    vcluster
  ];
}
