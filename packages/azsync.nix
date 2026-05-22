{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  openssl,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "azsync";
  version = "0.2.5";

  src = fetchFromGitHub {
    owner = "chkinney";
    repo = "azsync";
    tag = finalAttrs.version;
    hash = "sha256-5bSudRitNH16owry9oIjnhvJhwgITbR7wayC5GIZMMo=";
  };

  cargoHash = "sha256-9cUexBfZ3jKPjqcpZuxeD5UP4ix2AJxfd2OkMqvrE8M=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  meta = {
    description = "Quickly synchronize local secrets with Azure";
    homepage = "https://github.com/chkinney/azsync";
    license = lib.licenses.OR [
      lib.licenses.mit
      lib.licenses.asl20
    ];
  };
})
