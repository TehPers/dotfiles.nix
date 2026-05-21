{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.nushell;
in
{
  options.profiles.nushell = {
    enable = lib.mkEnableOption "Enable Nushell profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ nushell ];
    home.shell.enableNushellIntegration = true;
    home.file.".config/nushell/autoload" = {
      source = ./autoload;
    };

    programs.nushell.enable = true;
  };
}
