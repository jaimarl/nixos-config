{ config, lib, ... }: let
    option = config.modules.home.dunst;

    colors = config.lib.stylix.colors.withHashtag;
    fonts = config.stylix.fonts;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.home.dunst = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable { 
    
    services.dunst = {
        enable = true;
        settings = {
            global = {
                width = 500;
                height = 80;
                follow = "mouse";
                offset = "6x6";
                fullscreen = "pushback";
              
                markup = "full";
                format = "<b>%s</b>\n%b";
                show_indicators = false;

                frame_width = 1;
                corner_radius = 5;
                icon_corner_radius = 5;
                min_icon_size = 64;
                max_icon_size = 64;
                gap_size = 5;
                padding = 8;
                horizontal_padding = 8;
                text_icon_padding = 8;

                frame_color = colors.base01;
                background = colors.base00;
                foreground = colors.base05;
             
                font = "${fonts.sansSerif.name} ${toString (fonts.sizes.desktop)}";
            };

            urgency_low = { override_dbus_timeout = 2; };
            urgency_normal = { override_dbus_timeout = 4; };
            urgency_critical = {
                override_dbus_timeout = 6; 
                frame_color = colors.base08;
            };
        };
    };

};}
