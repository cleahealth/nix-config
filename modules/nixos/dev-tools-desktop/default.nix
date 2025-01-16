{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    beekeeper-studio
    discord # chat between developers, should be matrix instead but whatever
    google-chrome # extra chrome based browser for web development
    insomnia
    jetbrains-toolbox
    vscode
    zed-editor # text editor and IDE
  ];

  # Nerd Fonts for icons
  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    nerd-fonts.ubuntu-sans
  ];

}
