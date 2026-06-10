{ config, lib, pkgs, inputs, ... }: let 
    option = config.modules.home.zenBrowser;
in {

    imports = [
        inputs.zen-browser.homeModules.twilight
    ];

#--- [ Options ] ----------------------------------------------------
options.modules.home.zenBrowser = {
    enable = lib.mkOption { type = lib.types.bool; default = false; };

    hideNavigation = lib.mkEnableOption "Hide Navigation Buttons";
};


#--- [ Config ] -----------------------------------------------------
config = lib.mkIf option.enable {

    programs.zen-browser = {
        enable = true;

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

            AutofillAddressEnabled = false;
            AutofillCreditCardEnabled = false;
            PasswordManagerEnabled = false;
            OfferToSaveLogins = false;
            
            DisableFirefoxScreenshots = true;
            DisablePocket = true;
            DisableFirefoxStudies = true;
            DisableTelemetry = true;
            DisableAccounts = true;
            DisableFirefoxAccounts = true;
            DisableFeedbackCommands = true;
            GenerativeAI = { Enabled = false; };
            Permissions = {
                Notifications = { BlockNewRequests = true; };
                Location = { BlockNewRequests = true; };
            };
            EnableTrackingProtection = {
                Value = true;
                Cryptomining = true;
                Fingerprinting = true;
                Locked = true;
            };

            NoDefaultBookmarks = true;
            DontCheckDefaultBrowser = true;
            DisplayBookmarksToolbar = "always";
            DefaultDownloadDirectory = "~/Downloads";
        };
    
        profiles.default = {
            settings = {
                "browser.aboutConfig.showWarning" = false;
                "browser.translations.automaticallyPopup" = false;
                "browser.search.suggest.enabled" = true;
                "privacy.userContext.enabled" = false;
                "full-screen-api.warning.timeout" = 0;
                "zen.workspaces.continue-where-left-off" = true;
                "zen.tabs.show-newtab-vertical" = false;
                "zen.welcome-screen.seen" = true;
                "intl.locale.requested" = "ru";
            };

            mods = [
                "b51ff956-6aea-47ab-80c7-d6c047c0d510" # Disable Status Bar
                "e122b5d9-d385-4bf8-9971-e137809097d0" # No Top Sites
                "253a3a74-0cc4-47b7-8b82-996a64f030d5" # Floating History
                "4c2bec61-7f6c-4e5c-bdc6-c9ad1aba1827" # Vertical Split Tab Groups
                "599a1599-e6ab-4749-ab22-de533860de2c" # Pimp your PiP
            ];

            search = {
                force = true;
                default = "google";
                engines = let
                    nixSnowflakeIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                in {
                    "Nix Packages" = {
                        urls = [
                            {
                                template = "https://search.nixos.org/packages";
                                params = [
                                    {
                                        name = "type";
                                        value = "packages";
                                    }
                                    {
                                        name = "channel";
                                        value = "unstable";
                                    }
                                    {
                                        name = "query";
                                        value = "{searchTerms}";
                                    }
                                ];
                            }
                        ];
                        icon = nixSnowflakeIcon;
                        definedAliases = [ "@pkgs" ];
                    };
                    "Nix Options" = {
                        urls = [
                            {
                                template = "https://search.nixos.org/options";
                                params = [
                                    {
                                        name = "channel";
                                        value = "unstable";
                                    }
                                    {
                                        name = "query";
                                        value = "{searchTerms}";
                                    }
                                ];
                            }
                        ];
                        icon = nixSnowflakeIcon;
                        definedAliases = [ "@nopts" ];
                    };
                    "Home Manager Options" = {
                        urls = [
                            {
                                template = "https://home-manager-options.extranix.com/";
                                params = [
                                    {
                                        name = "query";
                                        value = "{searchTerms}";
                                    }
                                    {
                                        name = "release";
                                        value = "master";
                                    }
                                ];
                            }
                        ];
                        icon = nixSnowflakeIcon;
                        definedAliases = [ "@hmopts" ];
                    };
                };
            };

            userChrome = lib.mkIf option.hideNavigation ''
                .titlebar-buttonbox-container{ display:none !important }
                .titlebar-spacer { display: none !important }
            '';
        };
    };

};}
