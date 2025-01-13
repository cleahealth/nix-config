{ pkgs, ... }:

{
  imports = [
    ./gnome.nix
  ];

  # must-include packages for office/home usage enenvironment
  environment.systemPackages = with pkgs; [
    firefox # web browser
    ghostty # terminal for command line access
    trayscale # tailscale tray icon
    vlc # video player
  ];

  # font configuration, use Noto fonts as default
  fonts = {
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "Noto Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
    ];
  };

  # locale configuration, add zh_HK locale for non-server systems
  i18n = {
    defaultLocale = "en_US.UTF-8";
    # chinese input method
    inputMethod = {
      enable = true;
      type = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        table
        table-chinese
      ];
    };
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "zh_HK.UTF-8/UTF-8"
    ];
  };

  # additional rules for passwordless authorization to privileged operations
  security.polkit.extraConfig = ''
    // mounting without password for `storage` group
    polkit.addRule(function(action, subject) {
      var YES = polkit.Result.YES;
      var permission = {
        "org.freedesktop.udisks.filesystem-mount": YES,
        "org.freedesktop.udisks.luks-unlock": YES,
        "org.freedesktop.udisks.drive-eject": YES,
        "org.freedesktop.udisks.drive-detach": YES,
        "org.freedesktop.udisks2.filesystem-mount": YES,
        "org.freedesktop.udisks2.encrypted-unlock": YES,
        "org.freedesktop.udisks2.eject-media": YES,
        "org.freedesktop.udisks2.power-off-drive": YES,
        "org.freedesktop.udisks2.filesystem-mount-system": YES,
        "org.freedesktop.udisks2.filesystem-mount-other-seat": YES,
        "org.freedesktop.udisks2.filesystem-unmount-others": YES,
        "org.freedesktop.udisks2.encrypted-unlock-other-seat": YES,
        "org.freedesktop.udisks2.eject-media-other-seat": YES,
        "org.freedesktop.udisks2.power-off-drive-other-seat": YES
      };
      if (subject.isInGroup("storage")) {
        return permission[action.id];
      }
    });
  '';

  # for pipewire, as recommenden in wiki
  # https://wiki.nixos.org/wiki/PipeWire
  security.rtkit.enable = true;

  # audio configuration, use pipewire as a modern default
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  services.pulseaudio.enable = false; # prevent pipewire conficting pulseaudio

  # enable printing and scanning services
  services.printing.enable = true;
  services.saned.enable = true;

  # enable graphical services
  services.xserver.enable = true;

  # set timezone for desktop
  time.timeZone = "Asia/Hong_Kong";
}
