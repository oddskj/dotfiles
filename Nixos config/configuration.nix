# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
#  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  
  #plasma+i3
  #services.xserver.displayManager = {
  #  defaultSession = "plasma5+i3";
  #  session = [
  #      {
  #          manage = "desktop";
  #          name = "plasma5+i3";
  #          start = ''exec env KDEWM=${pkgs.i3}/bin/i3 ${pkgs.plasma-workspace}/bin/startplasma-x11'';
  #      }
  #  ];
#};




  # Enable i3 WM

  services.xserver.windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        synapse #application launcher
	#dmenu #application launcher most people use
        #i3status # gives you the default i3 status bar
	polybar
        i3lock-fancy #default i3 screen locker
        #i3blocks #if you are planning on using i3blocks over i3status
     ];
    };

  # Configure keymap in X11
  services.xserver = {
    layout = "no";
    xkbVariant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "no";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
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
  users.users.oddskj = {
    isNormalUser = true;
    description = "oddskj";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      kate
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	upower
     	wget
	python3
	picom
	neovim
	kitty
	alacritty
	git
	neofetch
	bspwm
	i3
	i3-rounded
	awesome
	feh
	xorg.xrandr
	arandr
	jetbrains.pycharm-community
	prismlauncher
	bluez
	bluez-alsa
	blueman
	steam
	nomacs
	spotify
	btop
	chromium
	speedtest-cli
	libsForQt5.plasma-nm
	vivaldi
	python311Packages.pip
	rofi
	pywal
	calc
	networkmanager_dmenu
	killall
	gh
	openssh
  ];

programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
};


fonts.fonts = with pkgs; [

	nerdfonts
	fantasque-sans-mono
	noto-fonts-cjk-sans
	borg-sans-mono
	terminus_font
	material-icons
	siji


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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
