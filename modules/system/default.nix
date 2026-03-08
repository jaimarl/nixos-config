{
    imports = [
        ./boot/tuigreet.nix
        ./boot/swap.nix
        ./boot/zram.nix

        ./hardware/bluetooth.nix
        ./hardware/wifi.nix

        ./shell/zsh.nix

        ./wm/hyprland

        ./virtualisation.nix
        ./gaming.nix
    ];
}
