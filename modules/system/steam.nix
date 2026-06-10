{ config, lib, ... }: let
    option = config.modules.system.steam;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.system.steam = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    programs.gamemode.enable = true;
    programs.steam = {
        enable = true;
        protontricks.enable = true;
    };

};}
