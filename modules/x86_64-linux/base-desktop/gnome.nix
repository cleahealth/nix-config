{ pkgs, ... }:

{

  # exclude GNOME console in favor of ghostty
  environment.gnome.excludePackages = with pkgs; [
    gnome-console
  ];

  # include dock and menu as default
  environment.systemPackages = with pkgs.gnomeExtensions; [
    appindicator
    arcmenu
    dash-to-dock
  ];

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

  # enable GNOME services
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
}
