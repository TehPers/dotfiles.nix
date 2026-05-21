{ pkgs, ... }:
{
  home.packages = with pkgs; [ nixfmt ];

  nix.package = pkgs.nix;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.max-jobs = "auto";
}
