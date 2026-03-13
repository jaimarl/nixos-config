{ config, osConfig, lib, ... }: 
let
    option = osConfig.modules.system.desktop.hyprland;
    
    runCmd = cmd: if (option.hypridle.onBatteryOnly)
        then "grep -q 'Discharging' /sys/class/power_supply/BAT*/status && ${cmd}" 
        else cmd;
in {

#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.hypridle.enable {

    services.hypridle = {
        enable = true;
        settings = {
            general = {
                lock_cmd = "pidof hyprlock || hyprlock";
                before_sleep_cmd = "loginctl lock-session";
                after_sleep_cmd = "hyprctl dispatch dpms on";
            };
            listener = [
                {
                    timeout = option.hypridle.timeouts.lock;
                    on-timeout = runCmd "loginctl lock-session";
                }
                {
                    timeout = option.hypridle.timeouts.offScreen;
                    on-timeout = runCmd "hyprctl dispatch dpms off";
                    on-resume = "hyprctl dispatch dpms on";
                }
            ] ++ lib.optionals (option.hypridle.kbdDevice != "") [
                {
                    timeout = option.hypridle.timeouts.offScreen;
                    on-timeout = runCmd "brightnessctl -sd ${option.hypridle.kbdDevice} set 0";
                    on-resume = "brightnessctl -rd ${option.hypridle.kbdDevice}";
                }
            ] ++ [
                {
                    timeout = option.hypridle.timeouts.suspend;
                    on-timeout = runCmd "systemctl suspend";
                }
            ];
        };
    };

};}
