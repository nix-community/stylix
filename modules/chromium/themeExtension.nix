{
  lib,
  manifest,
  stdenvNoCC,
  crx3rs,
  zip,
  ...
}:

let
  privateKey = ./themeExtension.pem;
  id = "hmgibhlknnhcnhjbhgpdholflkmjilgd";
in
stdenvNoCC.mkDerivation {
  name = "stylix-chromium-theme-extension.crx";
  version = "1.0";
  passthru = { inherit id; };
  dontUnpack = true;

  nativeBuildInputs = [
    crx3rs
    zip
  ];

  buildCommand = ''
    cp "${manifest}" ./manifest.json
    zip ./extension.zip ./manifest.json

    crx3rs create extension.zip "${privateKey}" "$out"
  '';
}
