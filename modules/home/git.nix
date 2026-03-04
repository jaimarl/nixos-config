{ config, lib, ... }: {
options.modules.home.git.enable = lib.mkEnableOption "Git";

config = lib.mkIf config.modules.home.git.enable {

    programs.git = {
        enable = true;
        settings.user.name = "jaimarl";
        settings.user.email = "jaimarl.me@gmail.com";
    };

};}
