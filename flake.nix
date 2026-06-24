{
  description = "Theming framework for NixOS, Home Manager, nix-darwin, and Nix-on-Droid";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default";

    # keep-sorted start block=yes newline_separated=yes
    base16-helix = {
      url = "github:tinted-theming/base16-helix";
      flake = false;
    };

    base16.url = "github:SenchoPens/base16.nix";

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };

    gnome-shell = {
      # TODO: Unlocking the input and pointing to official repository requires
      # updating the patch:
      # https://github.com/nix-community/stylix/pull/224#discussion_r1460339607.
      url = "github:GNOME/gnome-shell/ef02db02bf0ff342734d525b5767814770d85b49";
      flake = false;
    };

    tinted-kitty = {
      url = "github:tinted-theming/tinted-kitty";
      flake = false;
    };

    tinted-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };

    tinted-tmux = {
      url = "github:tinted-theming/tinted-tmux";
      flake = false;
    };

    tinted-zed = {
      url = "github:tinted-theming/base16-zed";
      flake = false;
    };
    # keep-sorted end
  };

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs =
    { flake-parts, systems, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./flake ];

      systems = import systems;
    };
}
