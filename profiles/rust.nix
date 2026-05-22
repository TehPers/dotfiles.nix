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
    home.packages = with pkgs; [
      cargo-audit
      cargo-binstall
      cargo-deny
      cargo-make
      cargo-update
      rustup
    ];
    home.sessionVariables = {
      CARGO_HOME = "${config.home.homeDirectory}/.cargo";
      RUSTUP_HOME = "${config.home.homeDirectory}/.rustup";
    };
  };
}
