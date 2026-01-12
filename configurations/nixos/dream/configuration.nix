# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dream";
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # resolve master hostname
  # networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";

  # Set your time zone.
  time.timeZone = "America/New_York";

  nix.settings = {
    # substituters = [ "https://hyprland.cachix.org" ];
    # trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # # Enable the X11 windowing system.
  # services.xserver = {
  #   enable = true;
  #   windowManager.i3.enable = true;
  #   videoDrivers = [ "amdgpu" ];
  # };
  # services.displayManager = {
  #   defaultSession = "none+i3";
  #   # Enable automatic login for the user.
  #   autoLogin = {
  #     enable = true;
  #     user = "ibecker";
  #   };
  # };
  #
  #
  # # Enable the GNOME Desktop Environment.
  # services.displayManager.gdm.enable = true;
  # services.desktopManager.gnome.enable = true;
  #
  # # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };
  security.polkit.enable = true;
  programs.sway.enable = true;
  console.keyMap = "us";
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd sway";
        user = "ibecker";
      };
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ibecker = {
    isNormalUser = true;
    description = "Ian Becker";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      #  thunderbird
      openrgb
    ];
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Install firefox.
  #programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    lact
    uutils-coreutils-noprefix
    vim
    curl

    lutris
    heroic
    mangohud

    dxvk
    steam-run

    clamav

    kubernetes
    kompose
    kubectl
    kustomize
    k3s
    k9s
    nfs-utils
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # networking.wg-quick.interfaces.wg0.configFile = "/home/ibecker/Downloads/wg-US-DC-26.conf";


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  programs.fish.enable = true;
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  catppuccin.enable = true;
  catppuccin.grub.enable = true;
  # catppuccin.grub.flavor = "macchiato";
  catppuccin.tty.enable = true;

  # services.matrix-synapse.enable = true;

  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;

  xdg.portal = {
    enable = true;

    config = {
      common = {
        default = [
          "gtk"
        ];
      };
      i3 = {
        default = [
          "gtk"
          "gnome"
        ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
      };
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };
  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];
}
