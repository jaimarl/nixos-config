{ pkgs, user, ... }: {
    programs.hyprland.enable = true;

    # Packages
    environment.systemPackages = with pkgs; [
        wl-clipboard
    ];

    # Home configuration
    home-manager.users.${user} = {
        programs.kitty.enable = true;
    };
}
