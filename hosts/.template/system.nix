{ config, hmConfig, lib, pkgs, user, ... }: let
    hostOption = config.host.system;
in {
    
    imports = [
        ./hardware.nix
        ./imports/packages-system.nix
        ./imports/services.nix
    ];

config = {

    # Set Host Options
    host.system = {
        # Default values
        # Check all options in common/imports/host-options.nix

        # hostname = "nixos";
        # locale = "ru_RU.UTF-8";
        # timeZone = "Europe/Moscow";
    };

    # Enable & Configure Modules
    modules.core = {
        # Core modules config (audio, graphics, ...)
    };

    modules.system = {

    };
	
#--------------------------------------------------------------------
    users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "power" ];
    };
};}
