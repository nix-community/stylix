{ config, lib, ... }: {
  stylix.testbed.ui.command = {
    text = lib.getExe config.lib.stylix.testbed.opencode;
    useTerminal = true;
  };

  # The package is pinned by the `nixpkgs-opencode-1` dev input, so that this
  # testbed keeps testing OpenCode 1 even once the main nixpkgs input moves to
  # OpenCode 2.
  assertions = [
    {
      assertion = lib.versionOlder (lib.getVersion config.lib.stylix.testbed.opencode) "2.0";
      message = "testbed:opencode-v1 requires an OpenCode 1 package, but got ${lib.getVersion config.lib.stylix.testbed.opencode}";
    }
  ];

  home-manager.sharedModules = lib.singleton {
    programs.opencode = {
      enable = true;
      package = config.lib.stylix.testbed.opencode;
    };
  };
}
