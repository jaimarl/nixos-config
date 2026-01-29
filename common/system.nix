{ config, hmConfig, lib, pkgs, stateVersion, user, ... }: let enabledModules = {
    modules.system = {
        # Enable Modules
        boot.bootloader.enable = true;
        boot.tuigreet.enable = true;
        hardware.graphics.enable = true;
        hardware.audio.enable = true;
        shell.aliases.enable = true;
        shell.zsh.enable = true;
        polkit.enable = true;
    };}; in {

    imports = [
        ./imports/packages.nix
        ./imports/services.nix
        ../modules/system/.imports.nix
    ];

config = enabledModules // {

    # Localization
    time.timeZone = "Europe/Moscow";
    i18n.defaultLocale = "ru_RU.UTF-8";

    console = {
        font = "ter-p24b";
        earlySetup = true;
        packages = [ pkgs.terminus_font ];
    };

    programs.hyprland.enable = hmConfig.modules.home.hyprland.enable;

#--------------------------------------------------------------------
    _module.args.hmConfig = config.home-manager.users.${user};
    
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = stateVersion;
};}
