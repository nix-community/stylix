{
  description = ''
    Private inputs for development purposes. These are used by the top level
    flake in the `dev` partition, but do not appear in consumers' lock files.
  '';

  inputs = {
    # We need to define a nixpkgs input so that other inputs can follow it.
    # It is prefixed with 'dev-' to avoid shadowing the public flake's
    # 'nixpkgs' input, which could affect local testing with --override-input.
    #
    # TODO: Replace
    #
    #           dev-nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    #
    #       with
    #
    #           dev-nixpkgs = {
    #             url = "path:../..";
    #             inputs = {
    #               "<PUBLIC_INPUT_1>".follows = "";
    #               "<PUBLIC_INPUT_2>".follows = "";
    #               "<PUBLIC_INPUT_3>".follows = "";
    #             };
    #           };
    #
    #       once 26.05 is released, giving non-flake end-users and Stylix
    #       contributors two LTS releases to adopt Nix 2.26+ [1]. Note that
    #       non-nixpkgs public flake inputs should be disabled.
    #
    #       [1]: https://github.com/NixOS/nix/blob/d4f67fd46dfe2bc950bdfa14273f87b8a4c32e47/doc/manual/source/release-notes/rl-2.26.md?plain=1#L3-L11
    dev-nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

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

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "dev-nixpkgs";
    };
    # keep-sorted end
  };

  # This flake is only used for its inputs.
  outputs = _: { };
}
