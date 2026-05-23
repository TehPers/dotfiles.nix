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
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ git-credential-manager ];

    programs.git.enable = true;
    programs.git.settings = {
      user.name = cfg.user;
      user.email = cfg.email;
      credential.helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
      credential.credentialStore = "secretservice";
      init.defaultbranch = "main";
    };

    # Git utilities should also be enabled
    profiles.cli-utils.git = true;
  };
}
