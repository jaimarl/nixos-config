{ config, lib, ... }: let
    option = config.modules.home.kitty;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.home.kitty = {
    enable = lib.mkEnableOption "Kitty Terminal";
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    global.home.terminal = "kitty";

    programs.kitty = {
        enable = true;

        settings = {
            confirm_os_window_close = 0;
            window_padding_width = 15;
            cursor_trail = 1;
        };
    };

};}
