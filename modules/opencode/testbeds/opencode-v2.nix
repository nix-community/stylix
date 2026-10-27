{ config, lib, ... }: {
  stylix.testbed.ui.command = {
    text = lib.getExe config.lib.stylix.testbed.opencode;
    useTerminal = true;
  };

  # The package is pinned by the `nixpkgs-opencode-2` dev input, so that this
  # testbed keeps testing OpenCode 2 even if the main nixpkgs input lags
  # behind.
  assertions = [
    {
      assertion = lib.versionAtLeast (lib.getVersion config.lib.stylix.testbed.opencode) "2.0";
      message = "testbed:opencode-v2 requires an OpenCode 2 package, but got ${lib.getVersion config.lib.stylix.testbed.opencode}";
    }
  ];

  home-manager.sharedModules = lib.singleton {
    programs.opencode = {
      enable = true;
      package = config.lib.stylix.testbed.opencode;
    };
  };
}
