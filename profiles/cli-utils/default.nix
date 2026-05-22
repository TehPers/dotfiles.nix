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

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        home.packages = with pkgs; [
          carapace
          dust
          fzf
          starship
          tokei
          zoxide
        ];

        programs.carapace.enable = true;
        programs.fzf.enable = true;
        programs.starship.enable = true;
        programs.zoxide.enable = true;
      }
      (lib.mkIf cfg.enablePowershellIntegration {
        home.file."${config.xdg.configHome}/powershell/profile.ps1".source = ./profile.ps1;
      })
      (lib.mkIf cfg.git {
        home.packages = with pkgs; [ gitui ];

        programs.gitui.enable = true;
      })
    ]
  );
}
