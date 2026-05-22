{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.rust;
in
{
  options.profiles.rust = {
    enable = lib.mkEnableOption "Enable Rust profile";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ rustup ];
    home.sessionVariables = {
      CARGO_HOME = "${config.xdg.configHome}/.cargo";
      RUSTUP_HOME = "${config.xdg.configHome}/.rustup";
    };
  };
}
