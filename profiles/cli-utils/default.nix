{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.cli-utils;
in
{
  options.profiles.cli-utils = {
    enable = lib.mkEnableOption "Enable CLI utilities";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        dust
        tokei
      ];

      programs.carapace.enable = true;
      programs.delta.enable = config.profiles.git.enable;
      programs.delta.enableGitIntegration = config.profiles.git.enable;
      programs.fzf.enable = true;
      programs.gitui.enable = config.profiles.git.enable;
      programs.ripgrep.enable = true;
      programs.starship.enable = true;
      programs.zoxide.enable = true;
    })

    (lib.mkIf (cfg.enable && config.profiles.powershell.enable) {
      home.file."${config.xdg.configHome}/powershell/profile.ps1".source = ./profile.ps1;
    })
  ];
}
