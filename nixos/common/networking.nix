{ host_info, ... }:

{
  networking = {
    hostName = host_info.name;
    networkmanager.enable = true;
  };
}
