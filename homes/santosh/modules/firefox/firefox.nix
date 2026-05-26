{ config, ... }:
{
  programs.firefox = {
    enable = false;

    configPath = "${config.xdg.configHome}/mozilla/firefox";

    policies = {
      AppAutoUpdate = false;
      DisablePocket = true;
      DisableTelemetry = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      OffferToSaveLoginsDefault = false;
      PasswordManagerEnabled = false;
      OfferToSaveLogins = false;
      DisplayBookmarksToolbar = "never";

      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };

      FirefoxHome = {
        "Search" = false;
        "TopSites" = false;
        "SponsoredTopSites" = false;
        "Highlights" = false;
        "Pocket" = false;
        "SponsoredPocket" = false;
      };
      ShowHomeButton = false;

      FirefoxSuggest = {
        "WebSuggestions" = true;
        "SponsoredSuggestions" = false;
        "ImproveSuggest" = true;
      };
      ExtensionSettings = import ./extension.nix;
    };
    profiles.default = {
      settings = {
        # Enable userChrome.css and userContent.css
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # Enable Autoscroll
        "general.autoScroll" = true;

        # Enable Scrolling on tabs to switch
        "toolkit.tabbox.switchByScrolling" = true;

        # Change browser homepage
        "browser.startup.homepage" = "https://vimlinuz.github.io/homerc";

        # Always restore session
        "browser.startup.page" = 3;

      };
      userChrome = builtins.readFile ./nyx_fox.css;
    };
  };
}
