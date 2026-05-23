{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.azsync;
in
{
  options.programs.azsync = {
    enable = lib.mkEnableOption "Azure-based environment synchronization";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (pkgs.callPackage ./packages/azsync.nix { })
    ];
  };
}
