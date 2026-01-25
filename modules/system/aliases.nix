{ config, lib, pkgs, host, user, ... }: {
    environment.shellAliases = let
        steam = config.programs.steam.enable;
        catppuccin = config.home-manager.users.${user}.catppuccin.enable;
        flavor = config.home-manager.users.${user}.catppuccin.flavor;
        theme = if flavor == "latte" then "frappe" else flavor;
    in {
        nswitch = "sudo nixos-rebuild switch --flake ~/.nixos/#${host}";
        nboot = "sudo nixos-rebuild boot --flake ~/.nixos/#${host}";
        ntest = "sudo nixos-rebuild test --flake ~/.nixos/#${host}";

        nclean = "sudo nix-collect-garbage && nix-store --optimize";
        nlistgen = "nixos-rebuild list-generations";
        ndelgen = "sudo nix-collect-garbage -d && nix-store --optimize && nswitch";

        nfixsteam = lib.mkIf (steam && catppuccin) "pkill steam; adwaita-steam-gtk -i -o 'color_theme:catppuccin-${theme};win_controls_layout:None'";
    };
}
