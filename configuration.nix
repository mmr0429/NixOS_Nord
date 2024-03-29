# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lenvnix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "pl";
    defaultLocale = "pl_PL.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim firefox curl tmux git htop glxinfo arc-theme arc-icon-theme zsh xlockmore vlc xarchiver unzip unrar gcc deluge gparted mupdf arandr keybase-gui rxvt_unicode lxappearance nitrogen pcmanfm 

  ];
  nixpkgs.config.allowUnfree = true; 

  hardware.brightnessctl.enable=true;
#  programs.light.enable=true;
    

  #Creates /etc/vimrc you can link that to ~/.vimrc
  environment.etc."vimrc".text = ''
    syntax on   
    set relativenumber
    colorscheme elflord
  '';
  

     
  #Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  
  nixpkgs.config.pulseaudio = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "pl";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  
  # Enable XFCE
  #services.xserver.desktopManager = {
  #  xfce.enable = true;
  #  default = "xfce";
  #};
 
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      i3status 
    ];
  };

  services.xserver.windowManager.i3.package = pkgs.i3-gaps; 
  services.compton.enable = true;
  networking.networkmanager.enable = true;



  hardware.opengl.driSupport32Bit = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.bluetooth.enable = true;
  #services.blueman.enable = true;
  
  programs.zsh.enable=true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maciej = {
    isNormalUser = true;
    shell=pkgs.zsh;
    home = "/home/maciej";
     
    extraGroups = [ "wheel" "networkmanager" "video" ]; 
  };

  #Flatpak configuration
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  services.flatpak.enable = true;


 
  services.tlp.enable = true;
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "intel_idle.max_cstate=1" ];
  boot.supportedFilesystems = [ "ntfs" ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}

