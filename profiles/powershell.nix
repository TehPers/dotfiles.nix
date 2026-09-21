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
    profileContent = lib.mkOption {
      default = "";
      type = lib.types.lines;
      description = "Content to be added to the default user `profile.ps1` file.";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.packages = with pkgs; [ powershell ];
    })

    (lib.mkIf (cfg.enable && cfg.profileContent != "") {
      home.file."${config.xdg.configHome}/powershell/profile.ps1".text = cfg.profileContent;
    })
  ];
}
