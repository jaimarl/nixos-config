{
    imports = [
        ./boot/tuigreet.nix
        ./boot/swap.nix
        ./boot/zram.nix

        ./desktop/hyprland
        
        ./hardware/bluetooth.nix
        ./hardware/wifi.nix

        ./steam.nix
        ./virtualisation.nix
        ./zapret.nix
    ];
}
