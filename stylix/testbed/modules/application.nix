{
  lib,
  config,
  pkgs,
  ...
}:
let
  user = lib.importTOML ../user.toml;
in
{
  options.stylix.testbed.ui = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.submodule {
        options = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            example = true;
            description = ''
              Whether to enable a standard configuration for testing graphical
              applications.

              This will automatically log in as the `${user.username}` user and
              launch an application or command.

              This is currently based on GNOME, but the specific desktop
              environment used may change in the future.
            '';
          };
          graphicalEnvironment = lib.mkOption {
            type = lib.types.enum (
              import ../available-graphical-environments.nix { inherit lib; }
            );
            default = "gnome";
            description = "The graphical environment to use.";
          };
          command = lib.mkOption {
            type = lib.types.nullOr (
              lib.types.submodule {
                options = {
                  packages = lib.mkOption {
                    type = lib.types.listOf lib.types.package;
                    description = ''
                      Packages forwarded to `environment.systemPackages`.
                    '';
                    default = [ ];
                  };
                  text = lib.mkOption {
                    type = lib.types.str;
                    description = ''
                      The command which will be run once the graphical
                      environment has loaded, which is deduced from
                      `config.stylix.testbed.ui.command.packages` when it
                      contains one package.
                    '';
                    default = "";
                  };
                  useTerminal = lib.mkOption {
                    type = lib.types.bool;
                    description = ''
                      Whether to spawn a terminal when running the command.
                    '';
                    default = false;
                    example = true;
                  };
                };
              }
            );
            default = null;
          };
          sendNotifications = lib.mkEnableOption "sending notifications of each urgency with libnotify";
        };
      }
    );
    default = null;
  };

  config = lib.mkIf (config.stylix.testbed.ui != null) {
    services.displayManager.autoLogin = {
      enable = true;
      user = user.username;
    };

    environment.systemPackages =
      builtins.concatMap
        (
          {
            condition,
            name,
            text,
            packages ? [ ],
            terminal ? false,
          }:
          let
            application = pkgs.writeShellApplication {
              text =
                if text != "" then
                  text
                else if builtins.length packages != 1 then
                  throw "text cannot be deduced from packages: ${
                    lib.generators.toPretty { } packages
                  }"
                else
                  (builtins.head packages).meta.mainProgram;

              name = name';
              runtimeInputs = packages;
            };

            autostartItem = pkgs.makeAutostartItem {
              name = name';
              package = desktopItem;
            };

            desktopItem = pkgs.makeDesktopItem {
              inherit terminal;

              desktopName = name';
              exec = lib.getExe application;
              name = name';
            };

            name' = "stylix-testbed" + lib.optionalString (name != "") "-${name}";
          in
          lib.optionals condition (
            [
              application
              autostartItem
              desktopItem
            ]
            ++ packages
          )
        )
        [
          {
            inherit (config.stylix.testbed.ui.command) packages text;

            condition = config.stylix.testbed.ui.command != null;
            name = "";
            terminal = config.stylix.testbed.ui.command.useTerminal;
          }
          {
            condition = config.stylix.testbed.ui.sendNotifications;
            name = "notification";
            packages = [ pkgs.libnotify ];

            text =
              lib.concatMapStringsSep " && "
                (urgency: "notify-send --urgency ${urgency} ${urgency} urgency")
                [
                  "low"
                  "normal"
                  "critical"
                ];
          }
        ];
  };
}
