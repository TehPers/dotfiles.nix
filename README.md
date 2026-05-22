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

## Profiles vs. roles

The modules in this repository are split into profiles and roles.

Profiles represent groups of configuration to enable a specific workflow. For
example, the "rust" profile installs tools needed to develop in Rust. Profiles
are enabled with `profile.profile-name.enable = true`. Some profiles accept
extra configuration as well, like the "git" profile.

Roles represent groups of profiles needed for an environment. For example, the
"dev" role enables tools needed for a development environment. Roles are enabled
with `roles.role-name.enable = true`.

The "nix" profile is always enabled as it configures Nix to work with flakes.
