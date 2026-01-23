# ❄️ NixOS Config
WIP
## 🛠️ Installation

Follow these steps to install the configuration on a new system. Ensure you have a stable internet connection.

1. **Boot from Live Media**
2. **Clone the repository:**

    ```bash
    git clone https://github.com/jaimarl/nixos-config
    cd nixos-config
    ```

3. **Create a new host configuration:**

    ```bash
    cp ./hosts/.template ./host/<host-name>
    git add .
    ```

4. **Register your host in `flake.nix`:**

     ```nix
     nixosConfigurations = {
         # State Version - NixOS version at the time of installation. Change only when reinstalling!
         # System - OS architecture. Optional, default: "x86_64-linux"
         # You MUST separet "=" with spaces, otherwise the installation script will not detect your host!
         <host-name> = addHost { host = "<host-name>"; stateVersion = "<state-version>"; user = <username>; system = "<arch>"; };
     };
     ```

     Optionally, you can add `disko.nix` to your host directory; if present, script will use it. This way, you can configure partitioning separately for each host.
  
5. **Run `install.sh`:**

     ```bash
     ./install.sh <host> <device>
     # E.g. ./install.sh t14-gen2 /dev/nvme0n1
     # If no device specified, system will be installed to the existing /mnt mountpoint
     # This way, you can manually partition and mount drive
     ```

6. **Done!**
