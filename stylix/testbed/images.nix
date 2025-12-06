{ fetchurl, runCommandLocal }:
{
  dark = fetchurl {
    name = "mountains.jpg";
    url = "https://unsplash.com/photos/ZqLeQDjY6fY/download?ixid=M3wxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNzE2MzY1NDY4fA&force=true";
    hash = "sha256-Dm/0nKiTFOzNtSiARnVg7zM0J1o+EuIdUQ3OAuasM58=";
  };

  light =
    let
      image = fetchurl {
        name = "three-bicycles.jpg";
        url = "https://unsplash.com/photos/hwLAI5lRhdM/download?ixid=M3wxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNzE2MzYxNDcwfA&force=true";
        hash = "sha256-S0MumuBGJulUekoGI2oZfUa/50Jw0ZzkqDDu1nRkFUA=";
      };

      # Create a path containing a space to test that `stylix.image` is
      # correctly quoted when used as a shell argument. We have to use a
      # directory as the parent because derivation names themselves cannot
      # contain spaces.
      directory = runCommandLocal "three-bicycles" { } ''
        mkdir "$out"
        cp ${image} "$out/three bicycles.jpg"
      '';
    in
    "${directory}/three bicycles.jpg";
}
