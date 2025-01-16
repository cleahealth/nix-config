{ ... }:

{
  users.users.thomasli = {
    extraGroups = [ "wheel" "docker" ];
    initialPassword = "admin"; # YOU MUST CHANGE THE PASSWORD AFTER FIRST LOGIN
    isNormalUser = true;
  };
}
