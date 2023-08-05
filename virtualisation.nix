{ pkgs, config, ... }:
{
  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };
}