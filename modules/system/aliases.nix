{ host, ... }: {
    environment.shellAliases = {
        nswitch = "sudo nixos-rebuild switch --flake ~/.nixos/#${host}";
        nboot = "sudo nixos-rebuild boot --flake ~/.nixos/#${host}";
        ntest = "sudo nixos-rebuild test --flake ~/.nixos/#${host}";

        nlistgen = "nixos-rebuild list-generations";
        # ndelgen = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations";
        # nclean = "sudo nix-collect-garbage -d && nix-store --optimize";
    };
}
