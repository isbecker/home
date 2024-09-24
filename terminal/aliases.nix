{ pkgs, ... }:
{
  home.shellAliases = {
    asl = "aws_sso_login";
    uac = "update_aws_config";
    uek = "update_eks_kubeconfig";

    # Terraform aliases
    tf = "${pkgs.terraform}/bin/terraform";
    tfi = "${pkgs.terraform}/bin/terraform init";
    tfv = "${pkgs.terraform}/bin/terraform validate";
    tfp = "${pkgs.terraform}/bin/terraform plan -out=tfplan";
    tfd = "${pkgs.terraform}/bin/terraform plan -destroy -out=tfplan";
    tfa = "${pkgs.terraform}/bin/terraform apply tfplan";
  };
}
