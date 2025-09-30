{ lib, ... }:
{
  name = "Obsidian";
  homepage = "https://obsidian.md";
  maintainers = with lib.maintainers; [
    TheColorman
    michaelgoldenn
  ];
}
