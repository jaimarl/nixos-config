{
     
#--- [ Config ] -----------------------------------------------------
config = {

    programs.fastfetch = {
        enable = true;
        settings = {
            logo = {
                source = toString (builtins.fetchurl {
                    url = "https://codeberg.org/permafrozen/ascii/raw/commit/1513bbc9a9e91ea3e9f70a88a27de9722bed3cf8/src/nixos_logo.txt";
                    sha256 = "sha256:0n5kg0bcd87gnsp0a0fls8v3zgbj5p582259bpl121rfb4fwggcj";
                });
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
                    format = "{pretty-name} {#2}[{protocol-name} {version}]";
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
                    format = "Uptime {days} days, {hours} hours, {minutes} minutes";
                }
                {
                    type = "disk";
                    key = "󰃭";
                    folser = "/";
                    format = "Installed {create-time:10} {#2}[{days} days ago]";
                }
            ];
        };
    };

};}
