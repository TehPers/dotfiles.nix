{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.git;
in
{
  options.profiles.git = {
    enable = lib.mkEnableOption "Enable Git profile";
    user = lib.mkOption {
      type = lib.types.str;
      example = "myuser";
      description = "Username to use in commits.";
    };
    email = lib.mkOption {
      type = lib.types.str;
      example = "myuser@example.com";
      description = "Email to use in commits.";
    };
    credentialStore = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      example = "secretservice";
      description = "The credential helper to use.";
      default = null;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.packages = with pkgs; [ git-credential-manager ];

      programs.git.enable = true;
      programs.git.settings = {
        user.name = cfg.user;
        user.email = cfg.email;
        credential.helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
        init.defaultbranch = "main";
      };
    })

    (lib.mkIf (cfg.enable && cfg.credentialStore != null) {
      programs.git.settings.credential.credentialStore = cfg.credentialStore;
    })
  ];
}
