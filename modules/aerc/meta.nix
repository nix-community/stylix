{ lib, ... }:
{
  name = "aerc";
  homepage = "https://git.sr.ht/~rjarry/aerc";
  maintainers = with lib.maintainers; [
    glyxambi
    naho
  ];
}
