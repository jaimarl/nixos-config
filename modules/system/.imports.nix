{
    imports = [
        ./boot/bootloader.nix
        ./boot/tuigreet.nix
        ./boot/swap.nix
        ./boot/zram.nix

        ./hardware/audio.nix
        ./hardware/graphics.nix
        ./hardware/bluetooth.nix
        ./hardware/wifi.nix

        ./shell/aliases.nix
        ./shell/zsh.nix

        ./wm/hyprland

        ./polkit-rules.nix
        ./virtualisation.nix
        ./gaming.nix
    ];
}
