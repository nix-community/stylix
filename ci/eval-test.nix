{
  imports = [
    ./nixos.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.stylix = {
      imports = [ ./hm.nix ];
    };
  };
}
