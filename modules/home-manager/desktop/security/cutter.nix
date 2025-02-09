{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.sylkos; let
  cfg = config.modules.desktop.security.cutter;
in {
  options.modules.desktop.security.cutter = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (cutter.withPlugins (ps: with ps; [jsdec rz-ghidra sigdb]))
    ];
  };
}
