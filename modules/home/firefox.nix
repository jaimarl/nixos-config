let mkUrl = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi"; in {
    programs.firefox = {
        enable = true;

        profiles.default = {
            isDefault = true;
            extensions.force = true;

            settings = {
                "browser.aboutConfig.showWarning" = false;
                "browser.translations.automaticallyPopup" = false;
                "browser.urlbar.suggest.calculator" = true;
                "intl.locale.requested" = "ru";
                "full-screen-api.warning.timeout" = 0;
            };
        };

        policies = {
            # Options
            DisableTelemetry = true;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableAccounts = true;
            DisableFirefoxAccounts = true;
            DisableFirefoxScreenshots = true;
            DontCheckDefaultBrowser = true;
            PasswordManagerEnabled = false;
            AutofillCreditCardEnabled = false;
            OverrideFirstRunPage = "";
            OverridePostUpdatePage = "";

            DisplayBookmarksToolbar = "always";
            DisplayMenuBar = "never";

            EnableTrackingProtection = {
              Value= true;
              Cryptomining = true;
              Fingerprinting = true;
              Locked = true;
            };

            Permissions = {
                Notifications = {
                    BlockNewRequests = true;
                    Locked = true;
                };
                Location = {
                    BlockNewRequests = true;
                    Locked = true;
                };
            };

            GenerativeAI = {
                Enabled = false;
                Locked = true;
            };

            FirefoxHome = {
                Search = false;
                TopSites = false;
                SponsoredTopSites = false;
                Locked = true;
            };

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
                # FFZ
                "frankerfacez@frankerfacez.com" = {
                    install_url = mkUrl "frankerfacez";
                    installation_mode = "force_installed";
                };
                # Firefox Color
                "FirefoxColor@mozilla.com" = {
                    install_url = mkUrl "firefox-color";
                    installation_mode = "force_installed";
                };
            };
        };
    };
}
