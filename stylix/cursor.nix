{ lib, config, ... }:
{
  options.stylix.cursor = lib.mkOption {
    description = ''
      Attributes defining the systemwide cursor. Set either all or none of
      these attributes.
    '';
    type = lib.types.nullOr (
      lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "cursor theming with stylix" // {
            default =
              lib.versionOlder (config.system.stateVersion or config.home.stateVersion
              ) "25.05"
              && builtins.any (x: x != null) (builtins.attrValues config.stylix.cursor);
            defaultText = lib.literalExpression ''
              lib.versionOlder (config.system.stateVersion or config.home.stateVersion) "25.05"
              && builtins.any (x: x != null) (builtins.attrValues config.stylix.cursor)
            '';
          };
          name = lib.mkOption {
            description = "The cursor name within the package.";
            type = lib.types.nullOr lib.types.str;
            default = null;
          };
          package = lib.mkOption {
            description = "Package providing the cursor theme.";
            type = lib.types.nullOr lib.types.package;
            default = null;
          };
          size = lib.mkOption {
            description = "The cursor size.";
            type = lib.types.nullOr lib.types.int;
            default = null;
          };
        };
      }
    );
    default = {
      enable =
        lib.versionOlder (config.system.stateVersion or config.home.stateVersion
        ) "25.05"
        && builtins.any (x: x != null) (builtins.attrValues config.stylix.cursor);
      name = null;
      package = null;
      size = null;
    };
    defaultText = lib.literalExpression ''
      {
        enable =
          lib.versionOlder (config.system.stateVersion or config.home.stateVersion) "25.05"
          && builtins.any (x: x != null) (builtins.attrValues config.stylix.cursor);
        name = null;
        package = null;
        size = null;
      }
    '';
  };
  config = {
    assertions =
      let
        inherit (config.stylix) cursor;
      in
      [
        {
          assertion =
            (cursor == null && cursor.enable)
            || cursor.name != null && cursor.package != null && cursor.size != null;
          message = ''
            stylix: `stylix.cursor` is only partially defined. Set either none or
            all of the `stylix.cursor` options.
          '';
        }
      ];
    warnings =
      lib.optional (config.stylix.cursor == null)
        "stylix: setting `stylix.cursor` to null is deprecated, instead set `stylix.cursor.enable` to `false`.";
  };
}
