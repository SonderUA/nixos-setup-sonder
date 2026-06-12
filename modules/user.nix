{ pkgs, user, lib, ... }: 
let
  capitalize = str:
    if str == "" then ""
    else (lib.toUpper (builtins.substring 0 1 str))
        + (builtins.substring 1 (builtins.stringLength str) str);
in { 
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = capitalize user;
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
