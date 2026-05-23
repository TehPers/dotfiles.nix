{
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.zsh;
in
{
  options.profiles.zsh = {
    enable = lib.mkEnableOption "Enable Zsh profile";
  };

  config = lib.mkIf cfg.enable {
    home.shell.enableZshIntegration = true;

    programs.zsh.enable = true;
    programs.zsh.localVariables = {
      USE_POWERLINE = "true";
      HAS_WIDECHARS = "false";
    };
    programs.zsh.initContent = ''
      # Source manjaro-zsh-configuration
      if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
        source /usr/share/zsh/manjaro-zsh-config
      fi
      # Use manjaro zsh prompt
      if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
        source /usr/share/zsh/manjaro-zsh-prompt
      fi
    '';
  };
}
