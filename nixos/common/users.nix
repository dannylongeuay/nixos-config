{ user_info, ... }:

{
  users.users."${user_info.name}" = {
    isNormalUser = true;
    description = "${user_info.description}";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
