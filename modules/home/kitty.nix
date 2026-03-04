{ config, lib, ... }: {
options.modules.home.kitty.enable = lib.mkEnableOption "Kitty Terminal";

config = lib.mkIf config.modules.home.kitty.enable {

    programs.kitty = {
        enable = true;

        settings = {
            confirm_os_window_close = 0;
            window_padding_width = 15;
            cursor_trail = 1;
        };
    };

};}
