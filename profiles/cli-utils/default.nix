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
    enablePowershellIntegration = lib.mkEnableOption "Enable Powershell integration";
    git = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Whether to enable git utilities";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        dust
        tokei
      ];

      programs.carapace.enable = true;
      programs.delta.enable = cfg.git;
      programs.delta.enableGitIntegration = cfg.git;
      programs.fzf.enable = true;
      programs.gitui.enable = cfg.git;
      programs.ripgrep.enable = true;
      programs.starship.enable = true;
      programs.zoxide.enable = true;
    })

    (lib.mkIf (cfg.enable && cfg.enablePowershellIntegration) {
      home.file."${config.xdg.configHome}/powershell/profile.ps1".source = ./profile.ps1;
    })
  ];
}
