# Base configuration for all linux systems
# Contains essential package and sensible default setting for all systems
# across the organization

{ pkgs, lib, ... }:

{

  # utility packages for every system
  environment.systemPackages = with pkgs; [
    btop # process monitor
    dig # for debugging DNS
    file # file information command
    jq # for running scripts on JSON data
    netcat # debugging network connections
    p7zip # unzip archives
    wget # file download utility
  ];

  # firewall is disabled by default
  networking.firewall.enable = lib.mkDefault false;

  # use networkmanager for network management
  # TODO: add options to use systemd-networkd instead
  networking.networkmanager = {
    enable = true;
    connectionConfig = {
      "connection.mdns" = 2;
    };
    # Networkmanager option by default install plugins that pulls in GTK
    # dependencies which are undesired for a minimal system.
    # Here, we override the default with prority 99, which allows additional
    # overrides (e.g. mkForce) from the user's configuration.
    # https://github.com/NixOS/nixpkgs/pull/164531
    # https://discourse.nixos.org/t/networkmanager-plugins-installed-by-default/39682
    plugins = lib.mkOverride 99 [];
  };

  # Allow proprietary packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    # Nix options for reducing storage spaces
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    # Enable flakes by default
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # for cloning configurations from git repository
  programs.git.enable = true;

  # for installing packages with dynamically linked libraries, such as VSCode
  # server
  programs.nix-ld.enable = true;

  # nvim as defualt editor for all users
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # to run commands in an unstable ssh session
  programs.tmux.enable = true;

  # ZSH Options
  programs.zsh = {
    enable = true;
    # install commonly used plugins
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  # enable SSH service for remote access
  services.openssh.enable = true;

  # use resolved for managing DNS
  services.resolved = {
    enable = true;
    extraConfig = "MulticastDNS=yes";
  };

  # enable Tailscale mesh VPN by default
  services.tailscale.enable = true;

  # use ZSH as default shell for all users
  users.defaultUserShell = pkgs.zsh;

  # enable zram as swap
  # refer to RFC on Fedora for details:
  # https://fedoraproject.org/wiki/Changes/SwapOnZRAM
  zramSwap.enable = true;
}
