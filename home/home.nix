{ homeStateVersion, user, ... }: {
  imports = [
    ./modules
    ./packages.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };

  programs.home-manager.enable = true;
}
