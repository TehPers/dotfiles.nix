{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.python;
in
{
  options.profiles.python = {
    enable = lib.mkEnableOption "Enable Python profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ uv ];

    programs.uv.enable = true;
  };
}
