{ config, osConfig, lib, pkgs, stateVersion, ... }: {

    imports = [
        ./imports/packages-home.nix
        ../core/home/stylix.nix
        ../modules/home
    ];


#--- [ Host Options ] -----------------------------------------------
options.host.home = {
    paths = {
        wallpapers = lib.mkOption { type = lib.types.str; default = "$HOME/Pictures/Wallpapers"; };
        screenshots = lib.mkOption { type = lib.types.str; default = "$HOME/Pictures/Screenshots"; };
        records = lib.mkOption { type = lib.types.str; default = "$HOME/Videos/Records"; };
    };
};


#--- [ Config ] -----------------------------------------------------
config = {

    # Options

};}
