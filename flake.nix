{
  description = "Personal Home Manager dotfiles";

  outputs =
    { self }:
    {
      lib.homeManager = ./default.nix;
    };
}
