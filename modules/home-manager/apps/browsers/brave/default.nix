{ config, lib, pkgs, inputs, ... }:
{
  options = {
    brave.enable =
      lib.mkEnableOption "Enable brave";
  };

  config = lib.mkIf config.brave.enable {
    home.packages = with pkgs; [
      brave
    ];

    environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.brave}/bin/brave";

    xdg.mime.defaultApplications = {
      "text/html" = "brave.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
      "x-scheme-handler/about" = "brave-browser.desktop";
      "x-scheme-handler/unknown" = "brave-browser.desktop";
    };
  };
}
