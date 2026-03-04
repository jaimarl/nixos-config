{
    imports = [
        ./boot/bootloader.nix
        ./boot/tuigreet.nix
        ./boot/swap.nix
        ./boot/zram.nix

        ./hardware/audio.nix
        ./hardware/audio-mono.nix
        ./hardware/graphics.nix
        ./hardware/graphics-nvidia.nix
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
