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
    enableBoa = lib.mkEnableOption "Enable the Boa runtime";
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        home.packages = with pkgs; [
          bun
          fnm
        ];

        programs.bun.enable = true;
      }
      (lib.mkIf cfg.enableBoa {
        home.packages = with pkgs; [ boa ];
      })
    ]
  );
}
