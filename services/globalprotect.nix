{ lib, ... }:
let
  gp_bin = "/opt/paloaltonetworks/globalprotect/PanGPUI";
  command = lib.strings.escapeShellArgs [
    gp_bin
    "start"
    "from-cli"
  ];
in
{
  systemd.user.services.globalprotect = {
    Unit = {
      Description = "GlobalProtect VPN";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "simple";
      Environment = "LD_LIBRARY_PATH=";
      ExecStart = command;
    };
  };
}



