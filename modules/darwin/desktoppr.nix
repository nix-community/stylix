{
  stdenv,
  fetchurl,
  lib,
  unzip,
}:
stdenv.mkDerivation {
  name = "hln";
  version = "0.5-218";
  pname = "hln";
  src = fetchurl {
    url = "https://github.com/scriptingosx/desktoppr/releases/download/v0.5/desktoppr-0.5-218.zip";
    hash = "sha256-Oa9gAQjOaJHYyT5JBUiFCxL1sQP1dqlFBm+GdmLHNNM=";
  };

  buildInputs = [
    unzip
  ];

  unpackPhase = ''
    runHook preUnpack

    unzip $src

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp -r desktoppr $out/bin

    runHook postInstall
  '';

}
