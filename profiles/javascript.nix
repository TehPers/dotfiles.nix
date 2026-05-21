{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.javascript;
in
{
  options.profiles.javascript = {
    enable = lib.mkEnableOption "Enable JavaScript profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bun
      fnm
    ];

    programs.bun.enable = true;
  };
}
