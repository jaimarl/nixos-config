{ config, lib, pkgs, user, ... }: {
options.modules.system.virtualisation.enable = lib.mkEnableOption "Virtualisation";

config = lib.mkIf config.modules.system.virtualisation.enable {

    environment.systemPackages = with pkgs; [
        spice-protocol
        virtio-win
        virtiofsd
    ];

    virtualisation = {
        libvirtd = {
            enable = true;
            qemu = {
                package = pkgs.qemu_kvm;
                swtpm.enable = true;
            };
            extraConfig = ''
                unix_sock_group = "libvirtd"
                unix_sock_rw_perms = "0770"
            '';
        };
        spiceUSBRedirection.enable = true;
    };

    programs.virt-manager.enable = true;

    users.users.${user}.extraGroups = [ "libvirtd" ];

};}
