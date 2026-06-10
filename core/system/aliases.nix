{ host, ... }: {

#--- [ Config ] -----------------------------------------------------
config = {

    environment.shellAliases = {
        nswitch = "sudo nixos-rebuild switch --flake /etc/nixos/#${host}";
        nboot = "sudo nixos-rebuild boot --flake /etc/nixos/#${host}";
        ntest = "sudo nixos-rebuild test --flake /etc/nixos/#${host}";
        nupdate = "sudo nix flake update --flake /etc/nixos && nswitch";

        nclean = "sudo nix-collect-garbage && nix-store --optimize";
        nlistgen = "nixos-rebuild list-generations";
        ndelgen = "sudo nix-collect-garbage -d && nswitch";

        ncd = "cd /etc/nixos/";
    };

};}
