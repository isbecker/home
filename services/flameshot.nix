{ flake, pkgs, ...}:
{
  services = {
    flameshot = {
      enable = true;
      settings = {
        General = {
          showStartupLaunchMessage = false;
        };
      };
    };
  };
  # required for flameshot service to start
  # flameshot service is required for copy to clipboard to function
  # https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
		Unit = {
			Description = "Home Manager System Tray";
			Requires = [ "graphical-session-pre.target" ];
		};
	};
}