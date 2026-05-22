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
        programs.starship.enable = true;
        programs.fzf.enable = true;
        programs.zoxide.enable = true;
      }
      (lib.mkIf cfg.git {
        home.packages = with pkgs; [ gitui ];

        programs.gitui.enable = true;
      })
    ]
  );
}
