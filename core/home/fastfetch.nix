{ config, lib, ... }: {
     
#--- [ Config ] -----------------------------------------------------
config = {

    programs.fastfetch = {
        enable = true;
        settings = {
            logo = {
                source = ../../assets/fastfetch-logo.txt;
            };
            display = {
                separator = "  󰁔  ";
                color = { keys = "blue"; };
                constants = [
                    "\u001b[48;2;56;59;78m"
                ];
            };
            modules = [
                {
                    type = "title";
                    key = "󰀄";
                }
                "break"
                {
                    type = "os";
                    key = "󱄅";
                    format = "{name} {#2}[{version}]";
                }
                {
                    type = "kernel";
                    key = "";
                    format = "{sysname} {#2}[{release}]";
                }
                {
                    type = "wm";
                    key = "󱂬";
                    format = "{pretty-name} {#2}[{version}]";
                }
                {
                    type = "shell";
                    key = "󰆍";
                    format = "{process-name} {#2}[{version}]";
                }
                "break"
                {
                    type = "cpu";
                    key = "󰍛";
                    format = "{name} {#2}[{cores-physical}/{cores-logical}]";
                }
                {
                    type = "gpu";
                    key = "󰍛";
                    format = "{vendor} {name} {#2}[z{driver}]";
                }
                {
                    type = "memory";
                    key = "󰍛";
                }
                "break"
                {
                    type = "uptime";
                    key = "󰥔";
                    format = "{days} days, {hours} hours, {minutes} minutes";
                }
                {
                    type = "disk";
                    key = "󰃭";
                    folser = "/";
                    format = "{create-time:10} {#2}[{days} days]";
                }
            ];
        };
    };

};}
