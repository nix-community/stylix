{ inputs, ... }: {
  perSystem =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      evaluate =
        sizeConfig:
        (lib.evalModules {
          specialArgs = { inherit pkgs; };
          modules = [
            ({ lib, ... }: { options.stylix.enable = lib.mkEnableOption "Stylix"; })
            ../../stylix/fonts.nix
            { stylix.fonts.sizes = sizeConfig; }
          ];
        }).config.stylix.fonts.sizes;

      explicit = evaluate {
        applications.px = 16.0;
        terminal.px = 15.5;
      };
      legacy = evaluate { applications = 12; };

      bemenuConfig =
        (inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            inputs.self.homeModules.stylix
            {
              home = {
                username = "test";
                homeDirectory = "/home/test";
                stateVersion = "26.05";
              };

              stylix = {
                enable = true;
                base16Scheme = "${inputs.self.inputs.tinted-schemes}/base16/catppuccin-macchiato.yaml";
                fonts.sizes.popups.px = 15.5;
              };
            }
          ];
        }).config;

      pointSize =
        px: if pkgs.stdenv.hostPlatform.isDarwin then px else px * 3.0 / 4.0;
      round = value: builtins.floor (value + 0.5);

      check =
        assert lib.assertMsg (
          explicit.applications.pt == pointSize 16.0
        ) "application point conversion is incorrect";
        assert lib.assertMsg (
          explicit.applications.rounded.pt == round (pointSize 16.0)
        ) "rounded application point conversion is incorrect";
        assert lib.assertMsg (
          explicit.terminal.pt == pointSize 15.5
        ) "terminal point conversion is incorrect";
        assert lib.assertMsg (
          explicit.terminal.rounded.pt == round (pointSize 15.5)
        ) "rounded terminal point conversion is incorrect";
        assert lib.assertMsg (
          legacy.applications.px == 16.0
        ) "legacy scalar conversion is incorrect";
        assert lib.assertMsg (
          legacy.applications.pt == pointSize 16.0
        ) "legacy platform point conversion is incorrect";
        assert lib.assertMsg (
          legacy.terminal.px == legacy.applications.px
        ) "terminal pixel inheritance is incorrect";
        assert lib.assertMsg (
          legacy.terminal.pt == legacy.applications.pt
        ) "terminal point inheritance is incorrect";
        assert lib.assertMsg (
          bemenuConfig.stylix.targets.bemenu.fontSize == pointSize 15.5
        ) "Bemenu font-size conversion is incorrect";
        assert lib.assertMsg (
          bemenuConfig.programs.bemenu.settings.fn
          == "${bemenuConfig.stylix.fonts.sansSerif.name} ${toString (pointSize 15.5)}"
        ) "Bemenu must preserve fractional Pango point sizes";
        pkgs.runCommand "font-size-units" { } ''
          touch "$out"
        '';
    in
    {
      checks.font-size-units = check;
      ci.nixbot.font-size-units = config.checks.font-size-units;
    };
}
