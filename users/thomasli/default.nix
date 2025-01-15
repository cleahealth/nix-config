{ ... }:

{
  users.users.thomasli = {
    extraGroups = [ "wheel" ];
    initialPassword = "admin"; # YOU MUST CHANGE THE PASSWORD AFTER FIRST LOGIN
    isNormalUser = true;
  };
}
