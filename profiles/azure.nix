{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.azure;
in
{
  options.profiles.azure = {
    enable = lib.mkEnableOption "Enable Azure profile";
    enableAzsync = lib.mkEnableOption "Enable azsync CLI";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      azure-cli
      azure-cli-extensions.application-insights
      azure-cli-extensions.bastion
      azure-cli-extensions.ssh
    ];

    programs.azsync.enable = cfg.enableAzsync;
  };
}
