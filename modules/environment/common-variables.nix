{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
      BROWSER = "brave";
      TERMINAL = "alacritty";

      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";
    };
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };
}
