{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.powershell;
in
{
  options.profiles.powershell = {
    enable = lib.mkEnableOption "Enable Powershell profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ powershell ];

    profiles.cli-utils.enablePowershellIntegration = true;
  };
}
