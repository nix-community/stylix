{ inputs, ... }: {
  perSystem =
    {
      lib,
      pkgs,
      system,
      ...
    }:
    let
      evalHM =
        extraModules:
        inputs.home-manager.lib.homeManagerConfiguration {
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
                enableReleaseChecks = false;
                base16Scheme = "${inputs.tinted-schemes}/base16/gruvbox-dark-hard.yaml";
              };
            }
          ]
          ++ extraModules;
        };

      baseColors = {
        base00 = "1d2021";
        base01 = "3c3836";
        base02 = "504945";
        base03 = "665c54";
        base04 = "bdae93";
        base05 = "d5c4a1";
        base06 = "ebdbb2";
        base07 = "fbf1c7";
        base08 = "fb4934";
        base09 = "fe8019";
        base0A = "fabd2f";
        base0B = "b8bb26";
        base0C = "8ec07c";
        base0D = "83a598";
        base0E = "d3869b";
        base0F = "d65d0e";
      };

      testColors = baseColors // {
        withHashtag = lib.mapAttrs (_: color: "#${color}") baseColors;
      };

      mkHmTarget =
        name:
        import ../../stylix/mk-target.nix {
          humanName = name;
          inherit name;
        };

      evalMinimal =
        extraModules:
        lib.evalModules {
          specialArgs = { inherit pkgs; };
          modules = [
            ../../stylix/target.nix
            ../../stylix/opacity.nix
            {
              options = {
                assertions = lib.mkOption {
                  type = lib.types.listOf lib.types.unspecified;
                  default = [ ];
                };
                lib = lib.mkOption {
                  type = lib.types.attrsOf lib.types.attrs;
                  default = { };
                };
                warnings = lib.mkOption {
                  type = lib.types.listOf lib.types.str;
                  default = [ ];
                };
              };
              config = {
                stylix.enable = true;
                lib.stylix.colors = testColors;
              };
            }
          ]
          ++ extraModules;
        };

      ashellModule =
        args:
        import ../../modules/ashell/hm.nix (
          args // { mkTarget = mkHmTarget "ashell"; }
        );

      hyprlandModule =
        args:
        import ../../modules/hyprland/hm.nix (
          args // { mkTarget = mkHmTarget "hyprland"; }
        );

      ashellOptionsModule = {
        options.programs.ashell = {
          enable = lib.mkEnableOption "ashell";
          settings = lib.mkOption {
            type = lib.types.attrsOf (lib.types.attrsOf lib.types.anything);
            default = { };
          };
        };
      };

      hyprlandBaseModule = {
        options = {
          services.hyprpaper.enable = lib.mkEnableOption "hyprpaper";
          stylix.targets.hyprpaper.enable = lib.mkEnableOption "hyprpaper";
          stylix.image = lib.mkOption {
            type = lib.types.nullOr lib.types.path;
            default = null;
          };
        };
      };

      allAssertionsPass = eval: builtins.all (a: a.assertion) eval.config.assertions;

      # 1. Target module absent (completely undeclared)
      ashellAbsent = evalMinimal [ ashellModule ];

      # 1b. Target module absent with `stylix.enable = false` (issue #721 class)
      ashellAbsentStylixDisabled = evalMinimal [
        ashellModule
        { stylix.enable = lib.mkForce false; }
      ];

      # 2. Target explicitly enabled while absent
      ashellAbsentExplicit = evalMinimal [
        ashellModule
        { stylix.targets.ashell.enable = true; }
      ];

      # 3. Target removed via `mkRemovedOptionModule` on namespace root
      #    (reproduces Home Manager's removal pattern from issue #2556)
      ashellRemovedNamespace = evalMinimal [
        ashellModule
        (lib.mkRemovedOptionModule [
          "programs"
          "ashell"
        ] "The ashell module has been removed.")
      ];

      # 4. Target removed via `mkRemovedOptionModule` on `enable` sub-option
      ashellRemovedEnable = evalMinimal [
        ashellModule
        (lib.mkRemovedOptionModule [
          "programs"
          "ashell"
          "enable"
        ] "The ashell module has been removed.")
      ];

      # 5. Target present: styling applies normally
      ashellPresent = evalMinimal [
        ashellOptionsModule
        ashellModule
      ];

      # 6. Hyprland absent (non-`programs.*` override target)
      hyprlandAbsent = evalMinimal [
        hyprlandBaseModule
        hyprlandModule
      ];

      # 7. Custom unlisted target without a `programs.*` module stays enabled
      customTarget = evalMinimal [
        {
          options.xdg.configFile = lib.mkOption {
            type = lib.types.attrsOf (lib.types.attrsOf lib.types.str);
            default = { };
          };
        }
        (mkHmTarget "custom-unlisted" {
          config = {
            xdg.configFile."custom/theme.conf".text = "styled";
          };
        })
      ];

      # 8. Invalid option inside an available target must still fail evaluation
      invalidOptionInAvailableTarget = evalMinimal [
        ashellOptionsModule
        (mkHmTarget "ashell" {
          requiredOptions = [
            [
              "programs"
              "ashell"
              "settings"
            ]
          ];
          config = {
            programs.ashell.nonExistentOption = true;
          };
        })
      ];

      # 9. Duplicate option declarations (e.g. Noctalia `checkConfig`) must still fail
      duplicateDeclaration = evalMinimal [
        { options.programs.ashell.checkConfig = lib.mkEnableOption "checkConfig"; }
        { options.programs.ashell.checkConfig = lib.mkEnableOption "checkConfig"; }
        (mkHmTarget "ashell" {
          requiredOptions = [
            [
              "programs"
              "ashell"
              "checkConfig"
            ]
          ];
          config = {
            programs.ashell.checkConfig = true;
          };
        })
      ];

      # 10. End-to-end Home Manager + full Stylix with upstream module removed via
      #     `mkRemovedOptionModule` (also verifies GTK & Hyprland stay active)
      fullHmAshellRemoved = evalHM [
        {
          disabledModules = [ "programs/ashell.nix" ];
          imports = [
            (lib.mkRemovedOptionModule [
              "programs"
              "ashell"
            ] "The ashell module has been removed.")
          ];
        }
      ];

      # 11. End-to-end Home Manager + full Stylix with upstream module removed AND
      #     explicitly enabled
      fullHmAshellRemovedExplicit = evalHM [
        {
          disabledModules = [ "programs/ashell.nix" ];
          imports = [
            (lib.mkRemovedOptionModule [
              "programs"
              "ashell"
            ] "The ashell module has been removed.")
          ];
          stylix.targets.ashell.enable = true;
        }
      ];

      tests = {
        ashell-absent-disables-target =
          !ashellAbsent.config.stylix.targets.ashell.enable
          && !(ashellAbsent.options ? programs)
          && ashellAbsent.config.warnings == [ ];

        ashell-absent-stylix-disabled-succeeds =
          !ashellAbsentStylixDisabled.config.stylix.enable
          && !ashellAbsentStylixDisabled.config.stylix.targets.ashell.enable
          && !(ashellAbsentStylixDisabled.options ? programs)
          && ashellAbsentStylixDisabled.config.warnings == [ ];

        ashell-absent-explicit-enable-skips-styling =
          ashellAbsentExplicit.config.stylix.targets.ashell.enable
          && !(ashellAbsentExplicit.options ? programs)
          && ashellAbsentExplicit.config.warnings == [ ];

        ashell-removed-namespace-disables-target =
          !ashellRemovedNamespace.config.stylix.targets.ashell.enable
          && !ashellRemovedNamespace.options.programs.ashell.isDefined
          && allAssertionsPass ashellRemovedNamespace
          && ashellRemovedNamespace.config.warnings == [ ];

        ashell-removed-enable-disables-target =
          !ashellRemovedEnable.config.stylix.targets.ashell.enable
          && !ashellRemovedEnable.options.programs.ashell.enable.isDefined
          && allAssertionsPass ashellRemovedEnable
          && ashellRemovedEnable.config.warnings == [ ];

        ashell-present-applies-styling =
          ashellPresent.config.stylix.targets.ashell.enable
          &&
            ashellPresent.config.programs.ashell.settings.appearance.primary_color
            == testColors.withHashtag.base0D
          &&
            ashellPresent.config.programs.ashell.settings.appearance.text_color
            == testColors.withHashtag.base05
          && ashellPresent.config.warnings == [ ];

        hyprland-absent-disables-target =
          !hyprlandAbsent.config.stylix.targets.hyprland.enable
          && !(hyprlandAbsent.options ? wayland)
          && hyprlandAbsent.config.warnings == [ ];

        custom-unlisted-target-not-disabled =
          customTarget.config.stylix.targets.custom-unlisted.enable
          && customTarget.config.xdg.configFile."custom/theme.conf".text == "styled";

        invalid-option-in-available-target-fails =
          !(builtins.tryEval (
            builtins.deepSeq invalidOptionInAvailableTarget.config true
          )).success;

        duplicate-declaration-still-fails =
          !(builtins.tryEval (
            builtins.deepSeq duplicateDeclaration.options.programs.ashell.checkConfig true
          )).success;

        full-hm-ashell-removed-and-non-program-targets-active =
          !fullHmAshellRemoved.config.stylix.targets.ashell.enable
          && !fullHmAshellRemoved.options.programs.ashell.isDefined
          && allAssertionsPass fullHmAshellRemoved
          && fullHmAshellRemoved.config.warnings == [ ]
          && fullHmAshellRemoved.config.stylix.targets.gtk.enable
          && fullHmAshellRemoved.config.gtk.theme.name == "adw-gtk3"
          && fullHmAshellRemoved.config.stylix.targets.hyprland.enable
          && fullHmAshellRemoved.config.wayland.windowManager.hyprland.settings ? config;

        full-hm-ashell-removed-explicit-enable-skips-styling =
          fullHmAshellRemovedExplicit.config.stylix.targets.ashell.enable
          && !fullHmAshellRemovedExplicit.options.programs.ashell.isDefined
          && allAssertionsPass fullHmAshellRemovedExplicit
          && fullHmAshellRemovedExplicit.config.warnings == [ ];
      };

      failed = builtins.attrNames (lib.filterAttrs (_: passed: !passed) tests);

      check =
        if failed != [ ] then
          throw "stylix: target-availability regression tests failed: ${lib.concatStringsSep ", " failed}"
        else
          pkgs.runCommand "target-availability" { } ''
            mkdir "$out"
          '';
    in
    {
      checks.target-availability = check;

      ci.nixbot = lib.mkIf (system == "x86_64-linux") {
        target-availability = check;
      };
    };
}
