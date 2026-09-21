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
      programs.bash.bashrcExtra = ''
        # fnm
        eval "$(fnm env --use-on-cd --shell bash)"
      '';
      profiles.powershell.profileContent = ''
        # fnm
        fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
      '';
      programs.zsh.initContent = ''
        # fnm
        eval "$(fnm env --use-on-cd --shell zsh)"
      '';
    })

    (lib.mkIf (cfg.enable && cfg.enableBoa) {
      home.packages = with pkgs; [ boa ];
    })
  ];
}
