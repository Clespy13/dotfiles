{ config, lib, pkgs, ... }:
{
  home.file = {
    ".config/mako" = {
      source = ./config;
      recursive = true;
    };
  };
}
