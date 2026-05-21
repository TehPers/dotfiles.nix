{
  description = "Personal Home Manager dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    {
      lib.dotfiles = ./.default.nix;
    };
}
