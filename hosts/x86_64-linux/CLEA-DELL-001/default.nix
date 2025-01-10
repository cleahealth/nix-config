{ inputs, ... }:

{
  imports = [
    inputs.disko.nixosModules.disko
    ../../../systems/x86_64-linux/proxmox-vm
    ./disk-config.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.05";
}
