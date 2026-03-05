{ config, hmConfig, lib, pkgs, host, user, ... }: let
    option = config.modules.system.shell.aliases;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.system.shell.aliases = {
    enable = lib.mkEnableOption "Global Aliases";
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    environment.shellAliases = {
        nswitch = "sudo nixos-rebuild switch --flake ~/.nixos/#${host}";
        nboot = "sudo nixos-rebuild boot --flake ~/.nixos/#${host}";
        ntest = "sudo nixos-rebuild test --flake ~/.nixos/#${host}";

        nclean = "sudo nix-collect-garbage && nix-store --optimize";
        nlistgen = "nixos-rebuild list-generations";
        ndelgen = "sudo nix-collect-garbage -d && nswitch";
    };

};}
