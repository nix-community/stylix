{
  mkTarget,
  pkgs,
  config,
  lib,
  ...
}:
mkTarget {
  name = "tuigreet";
  humanName = "TUIgreet";

  # Auto-enable only when greetd is enabled and configured to run TUIgreet
  autoEnable =
    pkgs.stdenv.hostPlatform.isLinux
    && (config.services.greetd.enable or false)
    && lib.hasInfix "tuigreet"
    (config.services.greetd.settings.default_session.command or "");
  autoEnableExpr = ''
    pkgs.stdenv.hostPlatform.isLinux && (config.services.greetd.enable or false)
    && lib.hasInfix "tuigreet" (config.services.greetd.settings.default_session.command or "")
  '';

  # Generate a complete ANSI --theme string and nudge users to wire it in
  configElements = [
    (
      {}: let themeString = config.lib.stylix.ansi.themeStringNearest; in {environment.etc."tuigreet/stylix.theme".text = themeString + "\n";}
    )
    {
      # Nudge users to wire the config into greetd if they are using tuigreet
      warnings = let
        cmd = config.services.greetd.settings.default_session.command or "";
        usesTuigreet = lib.hasInfix "tuigreet" cmd;
        hasTheme = lib.hasInfix "--theme" cmd;
        needsConfig = usesTuigreet && !hasTheme;
      in
        lib.optional needsConfig "stylix: tuigreet: services.greetd.settings.default_session.command does not include a '--theme' argument";
    }
  ];
}
