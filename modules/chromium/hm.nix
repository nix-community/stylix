{ lib, mkTarget, ... }: {
  imports =
    lib.mapAttrsToList
      (
        name: humanName:
        lib.modules.importApply ./each-config.nix { inherit mkTarget name humanName; }
      )
      {
        # See https://github.com/nix-community/home-manager/blob/ec172013fa62135f58fb58dd17ae9651e8f39727/modules/programs/chromium.nix#L12-L20
        chromium = "Chromium";
        google-chrome = "Google Chrome";
        google-chrome-beta = "Google Chrome Beta";
        google-chrome-dev = "Google Chrome Dev";
        brave = "Brave Browser";
        vivaldi = "Vivaldi Browser";
        microsoft-edge = "Microsoft Edge";
      };
}
