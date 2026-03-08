{ config, lib, host, ... }: let
    option = config.modules.core.aliases;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.core.aliases = {
    nixos.enable = lib.mkOption { type = lib.types.bool; default = true; };
};


#--- [ Config ] -----------------------------------------------------
config = {

    environment.shellAliases = lib.mkIf option.nixos.enable {
        nswitch = "sudo nixos-rebuild switch --flake ~/.nixos/#${host}";
        nboot = "sudo nixos-rebuild boot --flake ~/.nixos/#${host}";
        ntest = "sudo nixos-rebuild test --flake ~/.nixos/#${host}";

        nclean = "sudo nix-collect-garbage && nix-store --optimize";
        nlistgen = "nixos-rebuild list-generations";
        ndelgen = "sudo nix-collect-garbage -d && nswitch";
    };

};}
