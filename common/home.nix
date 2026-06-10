{ lib, ... }: {

    imports = [
        ./packages-home.nix
        ../core/home
        ../modules/home
        ../modules/home/scripts
    ];


#--- [ Host Options ] -----------------------------------------------
# DO NOT CHANGE VALUES, USE YOUR HOST CONFIG INSTEAD!
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
