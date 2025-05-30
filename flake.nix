{
  description = "Nix Configuration for provisioning workstations within CLEA";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs.url = "github:serokell/deploy-rs";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      darwin,
      deploy-rs,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        CLEA-DELL-001 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/x86_64-linux/CLEA-DELL-001
          ];
          specialArgs = { inherit inputs; };
        };
      };

      darwinConfigurations = {
        CLEA-MAC-001 = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            ./hosts/darwin/CLEA-MAC-001
          ];
          specialArgs = { inherit inputs; };
        };
      };

      deploy.nodes = {
        CLEA-DELL-001 = {
          hostname = "clea-dell-001";
          profiles.system = {
            sshUser = "admin";
            user = "root";
            interactiveSudo = true;
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.CLEA-DELL-001;
          };
        };
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

    };
}
