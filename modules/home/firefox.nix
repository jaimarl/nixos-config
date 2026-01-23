let mkUrl = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi"; in {
    programs.firefox = {
        enable = true;

        policies = {
            # Extensions
            ExtensionSettings = {
                # uBlock Origin
                "uBlock0@raymondhill.net" = {
                    install_url = mkUrl "ublock-origin";
                    installation_mode = "force_installed";
                };
                # SponsorBlock
                "sponsorBlocker@ajay.app" = {
                    install_url = mkUrl "sponsorblock";
                    installation_mode = "force_installed";
                };
                # Bitwarden
                "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
                    install_url = mkUrl "bitwarden-password-manager";
                    installation_mode = "force_installed";
                };
                # Hide YouTube Shorts
                "{88ebde3a-4581-4c6b-8019-2a05a9e3e938}" = {
                    install_url = mkUrl "hide-youtube-shorts";
                    installation_mode = "force_installed";
                };
                "frankerfacez@frankerfacez.com" = {
                    install_url = mkUrl "frankerfacez";
                    installation_mode = "force_installed";
                };
            };
        };
    };
}
