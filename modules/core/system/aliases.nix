{ config, lib, host, ... }: {

#--- [ Config ] -----------------------------------------------------
config = {

    environment.shellAliases = {
        nswitch = "sudo nixos-rebuild switch --flake ~/.nixos/#${host}";
        nboot = "sudo nixos-rebuild boot --flake ~/.nixos/#${host}";
        ntest = "sudo nixos-rebuild test --flake ~/.nixos/#${host}";
        nupdate = "sudo nix flake update --flake ~/.nixos && nswitch";

        nclean = "sudo nix-collect-garbage && nix-store --optimize";
        nlistgen = "nixos-rebuild list-generations";
        ndelgen = "sudo nix-collect-garbage -d && nswitch";
    };

};}
