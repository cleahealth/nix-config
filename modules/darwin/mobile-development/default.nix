{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    android-tools
    scrcpy
  ];

  homebrew = {
    brews = [
      "cocoapods"
    ];
    casks = [
      "flutter"
    ];
  };

}
