{ inputs, ... }:

{
  imports = [
    inputs.disko.nixosModules.disko
    ../../../profiles/nixos/devops-desktop
    ../../../systems/x86_64-linux/proxmox-vm
    ../../../users/admin
    ../../../users/thomasli
    ./disk-config.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "CLEA-DELL-001";

  system.stateVersion = "25.05";
}
