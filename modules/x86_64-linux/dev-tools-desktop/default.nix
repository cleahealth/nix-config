{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    beekeeper-studio
    insomnia
    jetbrains-toolbox
    vscode
    zed-editor # text editor and IDE
  ];

  # Nerd Fonts for icons
  fonts.fonts = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    nerd-fonts.ubuntu-sans
  ];

}
