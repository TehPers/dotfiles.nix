{
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.bash;
in
{
  options.profiles.bash = {
    enable = lib.mkEnableOption "Enable Bash profile";
  };

  config = lib.mkIf cfg.enable {
    home.shell.enableBashIntegration = true;

    programs.bash.enable = true;
  };
}
