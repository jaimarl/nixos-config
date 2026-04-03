{ config, lib, pkgs, users, ... }: let
    option = config.modules.system.virtualisation;
in {

#--- [ Options ] ---------------------------------------------------- 
options.modules.system.virtualisation = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

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
                verbatimConfig = ''
                    display_gl = "on"
                '';
            };
            extraConfig = ''
                unix_sock_group = "libvirtd"
                unix_sock_rw_perms = "0770"
            '';
        };
        spiceUSBRedirection.enable = true;
    };

    networking.firewall.checkReversePath = "loose"; # Важно для корректной работы NAT в виртуалках
    networking.firewall.trustedInterfaces = [ "virbr0" ];

    services.spice-vdagentd.enable = true;

    programs.virt-manager.enable = true;

    users.users = lib.genAttrs users (name: {
        extraGroups = [ "libvirtd" ];
    });

};}
