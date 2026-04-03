# ❄️ NixOS Config
WIP
## 🛠️ Installation

Follow these steps to deploy this configuration on a new machine

1. **Boot from Live Media:**
    Boot your target machine into the NixOS installer using a USB drive. Make sure you have a working internet connection.
    
2. **Clone the repository:**
    Once you're in the live environment, clone this repository and enter the directory:
    ```bash
    git clone https://github.com/jaimarl/nixos-config
    cd nixos-config
    ```

3. **Create a new host configuration:**
    You need to create a configuration for your specific machine:
    - Copy `./hosts/.template/`
    - Specify state version in `./hosts/<host-name>/state-version.nix`
    - **Optional:** You can add a `disko.nix` file inside your host's directory. If present, the installation script will use this specific disk layout instead of the global default.
  
4. **Run `install.sh`:**
    Execute the installation script by providing your host name and the target device.
    ```bash
    ./install.sh <host> [device]
    ```
    **Examples:**
    - **Fresh Install:** To partition and install on a specific drive:
        ```bash
        ./install.sh t14-gen2 /dev/nvme0n1
        ```
    - **Resume/Manual Install:** If you leave the `[device]` argument empty, the script will install to an already mounted `/mnt`. This is useful if you want to use a manually partitioned disk or if you need to resume an interrupted installation:
        ```bash
        ./install.sh t14-gen2
        ```
    **Out of Memory Error:**
    If the installation fails with an `Out of memory` error (common on machines with low RAM), you need to create a temporary swap file:
    ```bash
    sudo fallocate -l 8G /mnt/swapfile
    sudo chmod 600 /mnt/swapfile
    sudo mkswap /mnt/swapfile
    sudo swapon /mnt/swapfile
    ```

5. **Set user password:**
    After the installation completes successfully, reboot into your new system. Log in as root and set the password for your user account:
    ```bash
    passwd <username>
    ```

6. **Post-Installation Rebuild:**
    Once you are logged into your user environment, it is recommended to run the system rebuild command to ensure everything is synced:
    ```bash
    nswitch
    ```

7. **Done!**
