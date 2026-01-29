{ config, lib, pkgs, user, ... }: let enabledModules = {
    modules.system = {
        # Enable Modules
    };}; in {

    imports = [
        ./.hardware.nix
        ./imports/packages.nix
        ./imports/services.nix
    ];

config = enabledModules // {

    networking.hostName = "nixos";

#--------------------------------------------------------------------
    users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "power" ];
    };
};}
