# Personal dotfiles using Nix + Home Manager

This repository contains my personal configurations for Home Manager. It can be
imported as a flake or a module.

## Importing as a flake

In your `flake.nix`, add this as an import:

```nix
# flake.nix
{
  inputs = {
    dotfiles.url = "https://github.com/TehPers/dotfiles.nix";
    # ...
  };

  outputs =
    { dotfiles, ... }:
    {
      homeConfigurations.yourUser = home-manager.lib.homeManagerConfiguration {
        # ...
        modules = [
          dotfiles.lib.homeManager
          {
            roles = {
              # enable roles here
            };

            profiles = {
              # enable profiles here
            };
          }
          # ...
        ];
      };
    };
}
```

## Importing as a module

You can use `builtins.fetchGit` to fetch this repository. It can be imported
directly and used as a Home Manager module.

```nix
# home.nix
{
  imports = [
    (builtins.fetchGit {
      url = "https://github.com/TehPers/dotfiles.nix";
      rev = "...";
    }).outPath
  ];

  # ...
}
```
