{ config, hmConfig, lib, pkgs, host, user, ... }: {
options.modules.system.shell.aliases.enable = lib.mkEnableOption "Global Aliases";

config = lib.mkIf config.modules.system.shell.aliases.enable {

    environment.shellAliases = let
        steam = config.modules.system.gaming.enable;
        catppuccin = hmConfig.modules.home.catppuccin.enable;
        flavor = hmConfig.catppuccin.flavor;
        theme = if flavor == "latte" then "frappe" else flavor;
    in {
        nswitch = "sudo nixos-rebuild switch --flake ~/.nixos/#${host}";
        nboot = "sudo nixos-rebuild boot --flake ~/.nixos/#${host}";
        ntest = "sudo nixos-rebuild test --flake ~/.nixos/#${host}";

        nclean = "sudo nix-collect-garbage && nix-store --optimize";
        nlistgen = "nixos-rebuild list-generations";
        ndelgen = "sudo nix-collect-garbage -d && nswitch";

        nfixsteam = lib.mkIf (steam && catppuccin) "pkill steam; adwaita-steam-gtk -i -o 'color_theme:catppuccin-${theme};win_controls_layout:None'";
    };

    environment.interactiveShellInit = ''
        npkg() {xdg-open "https://search.nixos.org/packages?channel=unstable&query=$1"}
        nopt() {xdg-open "https://search.nixos.org/options?channel=unstable&query=$1"}
        nhopt() {xdg-open "https://home-manager-options.extranix.com/?query=$1&release=master"}
    '';

};}
