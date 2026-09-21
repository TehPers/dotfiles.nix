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

  config = lib.mkIf cfg.enable {
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

    profiles.powershell.profileContent = ''
      # starship
      Invoke-Expression (&starship init powershell)

      # zoxide
      Invoke-Expression (& { (zoxide init powershell | Out-String) })

      # carapace
      Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }
      Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
      carapace _carapace powershell | Out-String | Invoke-Expression
    '';
  };
}
