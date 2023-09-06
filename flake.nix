{
  description = "Rezzubs' NixOS Configuration";

  inputs = {
    nixpkgs.url = github:NixOs/nixpkgs/nixos-unstable;
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
