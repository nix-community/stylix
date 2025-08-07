{
  description = ''
    Private inputs for development purposes. These are used by the top level
    flake in the `dev` partition, but do not appear in consumers' lock files.
  '';

  # We need to define the dev-flake-parts, dev-nixpkgs, and dev-systems inputs
  # so that other inputs can follow it. They are prefixed with 'dev-' to avoid
  # shadowing public flake inputs, which could affect local testing with
  # --override-input.
  #
  # TODO: Remove the /flake/dev/public-and-dev-version-consistency.nix checks
  #       and replace
  #
  #           inputs = {
  #             dev-nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  #
  #             dev-flake-parts = {
  #               url = "github:hercules-ci/flake-parts";
  #               inputs.nixpkgs-lib.follows = "dev-nixpkgs";
  #             };
  #
  #             dev-systems.url = "github:nix-systems/default";
  #
  #             # keep-sorted start block=yes newline_separated=yes
  #             flake-compat.url = "github:edolstra/flake-compat";
  #
  #             git-hooks = {
  #               url = "github:cachix/git-hooks.nix";
  #               inputs = {
  #                 flake-compat.follows = "flake-compat";
  #                 nixpkgs.follows = "dev-nixpkgs";
  #               };
  #             };
  #
  #             home-manager = {
  #               url = "github:nix-community/home-manager";
  #               inputs.nixpkgs.follows = "dev-nixpkgs";
  #             };
  #
  #             nixvim = {
  #               url = "github:nix-community/nixvim";
  #               inputs = {
  #                 flake-parts.follows = "dev-flake-parts";
  #                 nixpkgs.follows = "dev-nixpkgs";
  #                 systems.follows = "dev-systems";
  #               };
  #             };
  #
  #             nvf = {
  #               url = "github:NotAShelf/nvf";
  #               inputs = {
  #                 nixpkgs.follows = "dev-nixpkgs";
  #                 systems.follows = "dev-systems";
  #               };
  #             };
  #             # keep-sorted end
  #           };
  #
  #       with
  #
  #           inputs = {
  #             stylix = {
  #               url = "path:../..";
  #               inputs = {
  #                 base16-fish.follows = "";
  #                 base16-helix.follows = "";
  #                 base16-vim.follows = "";
  #                 base16.follows = "";
  #                 firefox-gnome-theme.follows = "";
  #                 gnome-shell.follows = "";
  #                 nur.follows = "";
  #                 tinted-foot.follows = "";
  #                 tinted-kitty.follows = "";
  #                 tinted-schemes.follows = "";
  #                 tinted-tmux.follows = "";
  #                 tinted-zed.follows = "";
  #               };
  #             };
  #
  #             # keep-sorted start block=yes newline_separated=yes
  #             flake-compat.url = "github:edolstra/flake-compat";
  #
  #             git-hooks = {
  #               url = "github:cachix/git-hooks.nix";
  #               inputs = {
  #                 flake-compat.follows = "flake-compat";
  #                 nixpkgs.follows = "stylix/nixpkgs";
  #               };
  #             };
  #
  #             home-manager = {
  #               url = "github:nix-community/home-manager";
  #               inputs.nixpkgs.follows = "stylix/nixpkgs";
  #             };
  #
  #             nixvim = {
  #               url = "github:nix-community/nixvim";
  #               inputs = {
  #                 flake-parts.follows = "stylix/flake-parts";
  #                 nixpkgs.follows = "stylix/nixpkgs";
  #                 systems.follows = "stylix/systems";
  #               };
  #             };
  #
  #             nvf = {
  #               url = "github:NotAShelf/nvf";
  #               inputs = {
  #                 nixpkgs.follows = "stylix/nixpkgs";
  #                 systems.follows = "stylix/systems";
  #               };
  #             };
  #             # keep-sorted end
  #           };
  #
  #       once 26.05 is released, giving non-flake end-users and Stylix
  #       contributors two LTS releases to adopt Nix 2.26+ [1]. Note that
  #       non-nixpkgs public flake inputs should be disabled.
  #
  #       [1]: https://github.com/NixOS/nix/blob/d4f67fd46dfe2bc950bdfa14273f87b8a4c32e47/doc/manual/source/release-notes/rl-2.26.md?plain=1#L3-L11
  inputs = {
    dev-nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    dev-flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "dev-nixpkgs";
    };

    dev-systems.url = "github:nix-systems/default";

    # keep-sorted start block=yes newline_separated=yes
    flake-compat.url = "github:edolstra/flake-compat";

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "dev-nixpkgs";
      };
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "dev-nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        flake-parts.follows = "dev-flake-parts";
        nixpkgs.follows = "dev-nixpkgs";
        systems.follows = "dev-systems";
      };
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs = {
        nixpkgs.follows = "dev-nixpkgs";
        systems.follows = "dev-systems";
      };
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs = {
        nixpkgs.follows = "dev-nixpkgs";
        systems.follows = "dev-systems";
      };
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "dev-nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "dev-nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    # keep-sorted end
  };

  # This flake is only used for its inputs.
  outputs = _: { };
}
