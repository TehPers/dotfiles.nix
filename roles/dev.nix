{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.roles.dev;
in
{
  options.roles.dev = {
    enable = lib.mkEnableOption "Enable the dev role";
  };

  config = lib.mkIf cfg.enable {
    profiles = {
      bash.enable = true;
      cli-utils.enable = true;
      git.enable = true;
      javascript.enable = true;
      nushell.enable = true;
      python.enable = true;
      rust.enable = true;
    };
  };
}
