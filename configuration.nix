# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, stateVersion, hostname, inputs, lib, config, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules
      ./modules/packages.nix
      inputs.nix-data.nixosModules.nix-data
      inputs.xinux-modules.nixosModules.efiboot # or biosboot
      inputs.xinux-modules.nixosModules.meta
    ];

  networking.hostName = hostname; # Define your hostname.
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


nix = {
    enable = true;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    # Garbage collector.
    gc = {
      automatic = true;
      # options = "--delete-older-than 10d";
    };

    settings = {
      # download-buffer-size = 524288000; # 500 MiB to prevent buffer warnings

      # experimental-features = "nix-command flakes pipe-operators";
      substituters = [
        "https://cache.xinux.uz/?priority=10"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0=" # xinux
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      trusted-users = [
        "root"
        "umarbek" 
        "@wheel"
      ];
    };
  };

  system.stateVersion = stateVersion;
}
