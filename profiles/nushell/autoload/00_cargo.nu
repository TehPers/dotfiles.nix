# Add cargo and related commands to PATH
const CARGO_BIN = "~/.cargo/bin"
if ($CARGO_BIN | path exists) {
    $env.PATH = $env.PATH | prepend $CARGO_BIN
}
