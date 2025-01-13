{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    age
    ansible
    ansible-lint
    cfssl # for signing certificates on CLI
    cloudflared
    consul
    consul-template
    ctop
    deploy-rs # for deploying nixos configurations
    gnupg
    iperf # network speed testing
    minio-client
    neofetch # :D
    opentofu # Terraform witho shxt license
    sops # managing secrets
    temporal-cli # for managing temporal, durable execution engine
    terraform
    valkey # for valkey-cli to manage Redis and Valkey instances
    vault
    wander # TUI for Hashicorp nomad
  ];

  virtualisation.docker.enable = true;
}
