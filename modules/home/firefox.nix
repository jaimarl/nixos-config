{ config, lib, ... }: let 
    option = config.modules.home.firefox;
in {

#--- [ Options ] ----------------------------------------------------
options.modules.home.firefox = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };

    hideNavigation = lib.mkEnableOption "Hide Navigation Buttons";
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    programs.firefox = {
        enable = true;
        languagePacks = [ "ru" "en_US" ];

        profiles.default = {
            isDefault = true;
            extensions.force = true;

            settings = {
                "browser.aboutConfig.showWarning" = false;
                "browser.translations.automaticallyPopup" = false;
                "browser.urlbar.suggest.calculator" = true;
                "full-screen-api.warning.timeout" = 0;
                "intl.locale.requested" = "ru";
                "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            };

            userChrome = lib.mkIf option.hideNavigation ''
                .titlebar-buttonbox-container{ display:none !important }
                .titlebar-spacer { display: none !important }
            '';
        };

        policies = let
            mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
                installation_mode = "force_installed";
            });
        in {
            ExtensionSettings = mkExtensionSettings {
                "uBlock0@raymondhill.net" = "ublock-origin";
                "@searchengineadremover" = "searchengineadremover";
                "jid1-BoFifL9Vbdl2zQ@jetpack" = "decentraleyes";
                "jobcentertycoon@gmail.com" = "cookie-auto-decline";
                "{74145f27-f039-47ce-a470-a662b129930a}" = "clearurls";
                "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
                "sponsorBlocker@ajay.app" = "sponsorblock";
                "yt.to.notebooklm@gmail.com" = "youtube-to-notebooklm";
                "{0814291e-c531-4741-a8e7-9a3e8f62bf71}" = "remove-youtube-tracking";
                "{88ebde3a-4581-4c6b-8019-2a05a9e3e938}" = "hide-youtube-shorts";
                "frankerfacez@frankerfacez.com" = "frankerfacez";
                "firefox-extension@steamdb.info" = "steam-database";
            };

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
        };
    };

};}
