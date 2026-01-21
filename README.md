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

     ```diff
     nixosConfigurations = {
     # State Version - NixOS version at the time of installation. Later change only when reinstalling!
     # System - OS architecture. Optional, default: "x86_64-linux"
     +   host-name = addHost { host = "<host-name>"; stateVersion = "<state-version>"; system = "<arch>"; };
     };
     ```

5. **Optional. Edit `disko.nix`:**

    ```
    Default partitioning:
    <device>
    ├─<device>1   1G     /boot
    └─<device>2   100%   /
    ```
  
7. **Run `install.sh`:**

     ```bash
     ./install.sh <device> <host>
     # E.g. ./install.sh /dev/nvme0n1 t14-gen2

8. **Done!**
