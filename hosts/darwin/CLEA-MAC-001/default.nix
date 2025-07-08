{ inputs, pkgs, ... }:

{

  imports = [
    ../../../profiles/darwin/alltheway-desktop
    ../../../systems/macbook
  ];

  # packages used in workplace
  environment.systemPackages = with pkgs; [
    cfssl
    goreleaser
    minio-client
    scrcpy
    temporal-cli
    wander
  ];

  homebrew = {
    brews = [
      "hashicorp/tap/consul"
      "hashicorp/tap/consul-template"
      "hashicorp/tap/nomad"
      "hashicorp/tap/packer"
      "hashicorp/tap/vault"
      "ory/tap/hydra"
      "ory/tap/kratos"
      "stripe-cli"
    ];
    casks = [
      "google-chrome"
    ];
    masApps = {
      "Windows App" = 1295203466;
    };
    taps = [
      "hashicorp/tap"
      "ory/tap"
    ];
  };

  networking.hostName = "CLEA-MAC-001";

  system.primaryUser = "thomasli";
  users.users.thomasli = {
    # weird behaviour home-manager does not pick up home directory from hm config
    home = /Users/thomasli;
  };

}
