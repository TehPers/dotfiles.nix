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
    })

    (lib.mkIf (cfg.enable && config.profiles.bash.enable) {
      programs.bash.bashrcExtra = ''
        eval "$(fnm env --use-on-cd --shell bash)"
      '';
    })

    (lib.mkIf (cfg.enable && config.profiles.zsh.enable) {
      programs.zsh.initContent = ''
        eval "$(fnm env --use-on-cd --shell bash)"
      '';
    })

    (lib.mkIf (cfg.enable && cfg.enableBoa) {
      home.packages = with pkgs; [ boa ];
    })
  ];
}
