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

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.packages = with pkgs; ([ fnm ]);

      programs.bun.enable = true;
    })

    (lib.mkIf (cfg.enable && cfg.enableBoa) {
      home.packages = with pkgs; [ boa ];
    })
  ];
}
