{ lib, ... }: {
  name = "starship";
  homepage = "https://starship.rs";
  maintainers = with lib.maintainers; [
    andrebclark
    cluther
  ];
}
