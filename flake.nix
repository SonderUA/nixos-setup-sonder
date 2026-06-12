{
  description = "My system configuration";

  inputs = {
  
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    
    home-manager = { 
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
 
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let
    system = "x86_64-linux";
    homeStateVersion = "24.11";
    user = "umarbek";
    hostname = "nixos";
    stateVersion = "24.11";
    
    makeSystem = { hostname, stateVersion }: nixpkgs.lib.nixosSystem {
      inherit system; # Do you need this part? Is this the same as system = system;?
      specialArgs = {
        inherit inputs stateVersion hostname user;
      };

      modules = [
        ./configuration.nix
      ];
    };
    
  in {

    nixosConfigurations.${hostname} = makeSystem {
      inherit hostname stateVersion;
    };
    
    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit inputs homeStateVersion user;
      };

      modules = [
        ./home/home.nix
      ];
    };
  };
}
