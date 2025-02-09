# Configuration for EWW (Elkowar's Wacky Widgets)
{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.sylkos; let
  cfg = config.modules.desktop.services.eww;
in {
  options.modules.desktop.services.eww = {
    enable = mkBoolOpt false;

    # Override to pkgs.eww for non-wayland DE
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.eww-wayland;
    };

    # layout name... probably later should implement this as the script or something
    layout = mkStrOpt "leftbar";
  };

  config = let
    dependencies = with pkgs; [
      #ewwConfig.package
      #pkgs.sway
      #pkgs.swaysome
      #pkgs.bash
      #pkgs.bluez
      #pkgs.coreutils
      #pkgs.xdg-utils
      #pkgs.gawk
      #pkgs.gnugrep
      #pkgs.gnused
      #pkgs.procps
      #pkgs.findutils
      #pkgs.connman
      #pkgs.pulseaudio
      #pkgs.wireplumber
    ];
  in
    lib.mkIf (cfg.enable) {
      # home manager configuration

      programs.eww = {
        enable = true;
        package = cfg.package;
        configDir = "${osConfig.dotfiles.configDir}/eww";
      };

      home.packages = with pkgs; [
        jq
        socat
      ];
    };
}
