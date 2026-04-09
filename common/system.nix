{ config, lib, inputs, pkgs, stateVersion, ... }: let
    hostOption = config.host.system;

    hmUsers = config.home-manager.users;
    isHyprlandNeeded = lib.any 
        (cfg: lib.attrByPath [ "wayland" "windowManager" "hyprland" "enable" ] false cfg) 
        (builtins.attrValues hmUsers);
in {

    imports = [
        ./packages-system.nix
        ./services.nix
        ../core/system
        ../modules/system
    ];

#--- [ Host Options ] -----------------------------------------------
options.host.system = {
    hostname = lib.mkOption { type = lib.types.str; default = "nixos"; };
    locale = lib.mkOption { type = lib.types.str; default = "ru_RU.UTF-8"; };
    timeZone = lib.mkOption { type = lib.types.str; default = "Europe/Moscow"; };

    hasBattery = lib.mkOption { type = lib.types.bool; default = false; };
};


#--- [ Config ] -----------------------------------------------------
config = {

    networking.hostName = hostOption.hostname;
    time.timeZone = hostOption.timeZone;
    i18n.defaultLocale = hostOption.locale;

    console = {
        font = "ter-p24b";
        earlySetup = true;
        packages = [ pkgs.terminus_font ];
    };

    # Hyprland System
    programs.hyprland = {
        enable = isHyprlandNeeded;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    modules.system.boot.tuigreet = lib.mkIf isHyprlandNeeded { cmd = "start-hyprland"; };

#--------------------------------------------------------------------
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = stateVersion;

    nixpkgs.overlays = [ (import ../pkgs) ];
};}
