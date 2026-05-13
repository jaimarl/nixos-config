{ config, lib, ... }: let
    option = config.modules.home.kitty;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.home.kitty = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    programs.kitty = {
        enable = true;

        settings = {
            confirm_os_window_close = 0;
            window_padding_width = 15;
            cursor_trail = 1;
            cursor_shape = "beam";
        };
    };

};}
