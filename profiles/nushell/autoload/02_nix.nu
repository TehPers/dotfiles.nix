if (which ^nix | is-not-empty) {
    $env.PATH = $env.PATH | prepend ~/.nix-profile/bin
}
