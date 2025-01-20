{ pkgs, ... }:

{

  # exclude GNOME console in favor of ghostty
  environment.gnome.excludePackages = with pkgs; [
    gnome-console
  ];

  environment.systemPackages =
    with pkgs;
    [
      gnome-tweaks
      wl-clipboard # command line clipboard tool
    ]
    # include dock and menu as default
    ++ (with gnomeExtensions; [
      appindicator
      arcmenu
      dash-to-dock
    ]);

  # default GNOME settings
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        settings = {
          "org/gnome/shell" = {
            disable-user-extensions = false;
            enabled-extensions = [
              pkgs.gnomeExtensions.appindicator.extensionUuid
              pkgs.gnomeExtensions.arcmenu.extensionUuid
              pkgs.gnomeExtensions.dash-to-dock.extensionUuid
            ];
          };
        };
      }
    ];
  };

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "ghostty";
  };

  # theming for non GTK apps
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # enable GNOME services
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
}
