{ lib, ... }: {

    imports = [
        ./packages.nix

        ./features/fastfetch.nix
        ./features/stylix.nix

        ../../modules/home
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
