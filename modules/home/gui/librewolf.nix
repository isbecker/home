{ pkgs, flake, ... }:
{
  programs.browserpass = {
    enable = true;
    browsers = [
      "firefox"
      "librewolf"
    ];
  };
  programs.librewolf = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        containersForce = true;
        containers = {
          Work = {
            color = "orange";
            icon = "briefcase";
            id = 1;
          };
          Personal = {
            color = "blue";
            icon = "fingerprint";
            id = 3;
          };
        };
        search = {
          force = true;
          default = "ddg";
          engines = {
            "ddg" = {
              name = "DuckDuckGo";
              keyword = "d";
              searchUrl = "https://duckduckgo.com/?q={searchTerms}";
            };
            "google" = {
              name = "Google";
              keyword = "g";
              searchUrl = "https://www.google.com/search?q={searchTerms}";
            };
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
          };
        };
        extensions = {
          force = true;
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            firefox-color
            ublock-origin
            canvasblocker
            vimium
            browserpass
            darkreader
            cookie-autodelete
            sidebery
            auto-tab-discard
            aw-watcher-web
            localcdn
            sponsorblock
            reddit-enhancement-suite
            old-reddit-redirect
            h264ify
            enhancer-for-youtube
          ];
          settings."uBlock0@raymondhill.net".settings = {
            selectedFilterLists = [
              "ublock-filters"
              "ublock-badware"
              "ublock-privacy"
              "ublock-quick-fixes"
              "ublock-unbreak"
              "easylist"
              "adguard-generic"
              "adguard-mobile"
              "easyprivacy"
              "adguard-spyware-url"
              "urlhaus-1"
              "curben-phishing"
              "plowe-0"
              "fanboy-cookiemonster"
              "ublock-cookies-easylist"
              "adguard-cookies"
              "ublock-cookies-adguard"
              "fanboy-social"
              "adguard-social"
              "fanboy-thirdparty_social"
              "easylist-chat"
              "easylist-newsletters"
              "easylist-notifications"
              "easylist-annoyances"
              "adguard-mobile-app-banners"
              "adguard-other-annoyances"
              "adguard-popup-overlays"
              "adguard-widgets"
              "ublock-annoyances"
            ];
          };
        };
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # for userChrome to work
          "browser.startup.blankWindow" = "false";
          "font.name.monospace.x-western" = "Iosevka Nerd Font Mono";
          "font.name.serif.x-western" = "IosevkaTermSlab Nerd Font";
          "font.name.sans-serif.x-western" = "Iosevka Nerd Font";
        };
        userChrome = ''
          /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/hide_tabs_toolbar.css made available under Mozilla Public License v. 2.0
          See the above repository for updates as well as full license text. */

          /* Hides tabs toolbar */
          /* For OSX use hide_tabs_toolbar_osx.css instead */

          /* Note, if you have either native titlebar or menubar enabled, then you don't really need this style.
          * In those cases you can just use: #TabsToolbar{ visibility: collapse !important }
          */

          /* IMPORTANT */
          /*
          Get window_control_placeholder_support.css
          Window controls will be all wrong without it
          */

          :root[tabsintitlebar]{ --uc-toolbar-height: 40px; }
          :root[tabsintitlebar][uidensity="compact"]{ --uc-toolbar-height: 32px }

          #TabsToolbar{ visibility: collapse !important }

          :root[sizemode="fullscreen"] #TabsToolbar > :is(#window-controls,.titlebar-buttonbox-container){
              visibility: visible !important;
              z-index: 2;
          }

          :root:not([inFullscreen]) #nav-bar{
              margin-top: calc(0px - var(--uc-toolbar-height,0px));
          }

          :root[tabsintitlebar] #toolbar-menubar[autohide="true"]{
              min-height: unset !important;
              height: var(--uc-toolbar-height,0px) !important;
              position: relative;
          }

          #toolbar-menubar[autohide="false"]{
              margin-bottom: var(--uc-toolbar-height,0px)
          }

          :root[tabsintitlebar] #toolbar-menubar[autohide="true"] #main-menubar{
              flex-grow: 1;
              align-items: stretch;
              background-color: var(--toolbar-bgcolor,--toolbar-non-lwt-bgcolor);
              background-clip: padding-box;
              border-right: 30px solid transparent;
              border-image: linear-gradient(to left, transparent, var(--toolbar-bgcolor,--toolbar-non-lwt-bgcolor) 30px) 20 / 30px
          }

          #toolbar-menubar:not([inactive]){ z-index: 2 }
          #toolbar-menubar[autohide="true"][inactive] > #menubar-items {
              opacity: 0;
              pointer-events: none;
              margin-left: var(--uc-window-drag-space-pre,0px)
          }
          /* This is a workaround for fx 119 specifically for users that use default theme, should remove when 120 is released. See bug 1853524 */
          :root:not(:-moz-lwtheme){
              --toolbar-non-lwt-bgcolor: #f9f9fb !important;
          }
          /* ...and for dark variant */
          @media (prefers-color-scheme: dark){
              :root:not(:-moz-lwtheme){
              --toolbar-non-lwt-bgcolor: rgb(43, 42, 51) !important;
              }
          }

          /*---+---+---+---+---+---+---+
          | C | O | L | O | U | R | S |
          +---+---+---+---+---+---+---*/


          @media (prefers-color-scheme: dark) { :root {

            /* These colours are (mainly) used by the
              Container Tabs Plugin */
            --uc-identity-colour-blue:      #8AADF4;
            --uc-identity-colour-turquoise: #8BD5CA;
            --uc-identity-colour-green:     #A6DA95;
            --uc-identity-colour-yellow:    #EED49F;
            --uc-identity-colour-orange:    #F5A97F;
            --uc-identity-colour-red:       #ED8796;
            --uc-identity-colour-pink:      #F5BDE6;
            --uc-identity-colour-purple:    #C6A0F6;

            /*  Cascades main Colour Scheme */
            --uc-base-colour:               #24273A;
            --uc-highlight-colour:          #1E2030;
            --uc-inverted-colour:           #CAD3F5;
            --uc-muted-colour:              #6E738D;
            --uc-accent-colour:             var(--uc-identity-colour-purple);

          }}


          @media (prefers-color-scheme: light) { :root {

            /* These colours are (mainly) used by the
              Container Tabs Plugin */
            --uc-identity-colour-blue:      #1E66F5;
            --uc-identity-colour-turquoise: #179299;
            --uc-identity-colour-green:     #40A02B;
            --uc-identity-colour-yellow:    #DF8E1D;
            --uc-identity-colour-orange:    #FE640B;
            --uc-identity-colour-red:       #D20F39;
            --uc-identity-colour-pink:      #D20F39;
            --uc-identity-colour-purple:    #8839EF;

            /*  Cascades main Colour Scheme */
            --uc-base-colour:               #EFF1F5;
            --uc-highlight-colour:          #DCE0E8;
            --uc-inverted-colour:           #4C4F69;
            --uc-muted-colour:              #9CA0B0;
            --uc-accent-colour:             var(--uc-identity-colour-purple);

          }}






          /* Down here I'm just reassigning variables based on the colours set above.
            Feel free to play around with these but there is no editing necessary below this line. c:
            */

          :root {

            --lwt-frame: var(--uc-base-colour) !important;
            --lwt-accent-color: var(--lwt-frame) !important;
            --lwt-text-color: var(--uc-inverted-colour) !important;

            --toolbar-field-color: var(--uc-inverted-colour) !important;

            --toolbar-field-focus-color: var(--uc-inverted-colour) !important;
            --toolbar-field-focus-background-color: var(--uc-highlight-colour) !important;
            --toolbar-field-focus-border-color: transparent !important;

            --toolbar-field-background-color: var(--lwt-frame) !important;
            --lwt-toolbar-field-highlight: var(--uc-inverted-colour) !important;
            --lwt-toolbar-field-highlight-text: var(--uc-highlight-colour) !important;
            --urlbar-popup-url-color: var(--uc-accent-colour) !important;

            --lwt-tab-text: var(--lwt-text-colour) !important;

            --lwt-selected-tab-background-color: var(--uc-highlight-colour) !important;

            --toolbar-bgcolor: var(--lwt-frame) !important;
            --toolbar-color: var(--lwt-text-color) !important;
            --toolbarseparator-color: var(--uc-accent-colour) !important;
            --toolbarbutton-hover-background: var(--uc-highlight-colour) !important;
            --toolbarbutton-active-background: var(--toolbarbutton-hover-background) !important;

            --lwt-sidebar-background-color: var(--lwt-frame) !important;
            --sidebar-background-color: var(--lwt-sidebar-background-color) !important;

            --urlbar-box-bgcolor: var(--uc-highlight-colour) !important;
            --urlbar-box-text-color: var(--uc-muted-colour) !important;
            --urlbar-box-hover-bgcolor: var(--uc-highlight-colour) !important;
            --urlbar-box-hover-text-color: var(--uc-inverted-colour) !important;
            --urlbar-box-focus-bgcolor: var(--uc-highlight-colour) !important;

          }



          .identity-color-blue      { --identity-tab-color: var(--uc-identity-colour-blue)      !important; --identity-icon-color: var(--uc-identity-colour-blue)      !important;  }
          .identity-color-turquoise { --identity-tab-color: var(--uc-identity-colour-turquoise) !important; --identity-icon-color: var(--uc-identity-colour-turquoise) !important; }
          .identity-color-green     { --identity-tab-color: var(--uc-identity-colour-green)     !important; --identity-icon-color: var(--uc-identity-colour-green)     !important; }
          .identity-color-yellow    { --identity-tab-color: var(--uc-identity-colour-yellow)    !important; --identity-icon-color: var(--uc-identity-colour-yellow)    !important; }
          .identity-color-orange    { --identity-tab-color: var(--uc-identity-colour-orange)    !important; --identity-icon-color: var(--uc-identity-colour-orange)    !important; }
          .identity-color-red       { --identity-tab-color: var(--uc-identity-colour-red)       !important; --identity-icon-color: var(--uc-identity-colour-red)       !important; }
          .identity-color-pink      { --identity-tab-color: var(--uc-identity-colour-pink)      !important; --identity-icon-color: var(--uc-identity-colour-pink)      !important; }
          .identity-color-purple    { --identity-tab-color: var(--uc-identity-colour-purple)    !important; --identity-icon-color: var(--uc-identity-colour-purple)    !important; }
        '';
      };
    };
  };
}
