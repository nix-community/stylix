{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) optionalAttrs;
  inherit (config.lib.stylix) colors;

  chromaXml = pkgs.writeText "stylix-chroma.xml" ''
    <style name="stylix">
      <entry type="Background" style="bg:#${colors.base00}"/>
      <entry type="LineHighlight" style="bg:#${colors.base02}"/>
      <entry type="LineNumbers" style="#${colors.base04}"/>
      <entry type="LineNumbersTable" style="#${colors.base04}"/>
      <entry type="LineTableTD" style=""/>
      <entry type="LineTable" style=""/>
      <entry type="CodeLine" style="#${colors.base05}"/>
      <entry type="Text" style="#${colors.base05}"/>
      <entry type="Punctuation" style="#${colors.base05}"/>
      <entry type="TextWhitespace" style="#${colors.base05}"/>
      <entry type="Other" style="#${colors.base05}"/>
      <entry type="Name" style="#${colors.base05}"/>
      <entry type="NameOther" style="#${colors.base05}"/>
      <entry type="NameConstant" style="#${colors.base0A}"/>
      <entry type="NameDecorator" style="bold #${colors.base0D}"/>
      <entry type="NameEntity" style="#${colors.base0C}"/>
      <entry type="NameException" style="#${colors.base09}"/>
      <entry type="NameNamespace" style="#${colors.base09}"/>
      <entry type="Literal" style="#${colors.base05}"/>
      <entry type="LiteralDate" style="#${colors.base05}"/>
      <entry type="Generic" style="#${colors.base05}"/>
      <entry type="GenericOutput" style="#${colors.base05}"/>
      <entry type="GenericPrompt" style="#${colors.base05}"/>
      <entry type="GenericStrong" style="#${colors.base05}"/>
      <entry type="GenericTraceback" style="#${colors.base05}"/>
      <entry type="Keyword" style="#${colors.base0E}"/>
      <entry type="KeywordReserved" style="#${colors.base0E}"/>
      <entry type="KeywordPseudo" style="#${colors.base0E}"/>
      <entry type="KeywordConstant" style="#${colors.base09}"/>
      <entry type="KeywordDeclaration" style="#${colors.base08}"/>
      <entry type="KeywordNamespace" style="#${colors.base0C}"/>
      <entry type="KeywordType" style="#${colors.base08}"/>
      <entry type="NameFunction" style="#${colors.base0D}"/>
      <entry type="NameFunctionMagic" style="#${colors.base0D}"/>
      <entry type="NameAttribute" style="#${colors.base0D}"/>
      <entry type="NameClass" style="#${colors.base0A}"/>
      <entry type="NameBuiltin" style="#${colors.base0C}"/>
      <entry type="NameBuiltinPseudo" style="#${colors.base0C}"/>
      <entry type="NameLabel" style="#${colors.base0C}"/>
      <entry type="NameVariable" style="#${colors.base05}"/>
      <entry type="NameVariableClass" style="#${colors.base05}"/>
      <entry type="NameVariableGlobal" style="#${colors.base05}"/>
      <entry type="NameVariableInstance" style="#${colors.base05}"/>
      <entry type="NameVariableMagic" style="#${colors.base05}"/>
      <entry type="NameProperty" style="#${colors.base09}"/>
      <entry type="NameTag" style="#${colors.base0E}"/>
      <entry type="LiteralString" style="#${colors.base0B}"/>
      <entry type="LiteralStringChar" style="#${colors.base0B}"/>
      <entry type="LiteralStringSingle" style="#${colors.base0B}"/>
      <entry type="LiteralStringDouble" style="#${colors.base0B}"/>
      <entry type="LiteralStringBacktick" style="#${colors.base0B}"/>
      <entry type="LiteralStringOther" style="#${colors.base0B}"/>
      <entry type="LiteralStringSymbol" style="#${colors.base0B}"/>
      <entry type="LiteralStringInterpol" style="#${colors.base0B}"/>
      <entry type="LiteralStringHeredoc" style="#${colors.base04}"/>
      <entry type="LiteralStringDoc" style="#${colors.base04}"/>
      <entry type="LiteralStringEscape" style="#${colors.base0C}"/>
      <entry type="LiteralStringRegex" style="#${colors.base0C}"/>
      <entry type="LiteralStringDelimiter" style="#${colors.base0D}"/>
      <entry type="LiteralStringAffix" style="#${colors.base0E}"/>
      <entry type="LiteralNumber" style="#${colors.base09}"/>
      <entry type="LiteralNumberBin" style="#${colors.base09}"/>
      <entry type="LiteralNumberHex" style="#${colors.base09}"/>
      <entry type="LiteralNumberInteger" style="#${colors.base09}"/>
      <entry type="LiteralNumberFloat" style="#${colors.base09}"/>
      <entry type="LiteralNumberIntegerLong" style="#${colors.base09}"/>
      <entry type="LiteralNumberOct" style="#${colors.base09}"/>
      <entry type="Operator" style="bold #${colors.base0C}"/>
      <entry type="OperatorWord" style="bold #${colors.base0C}"/>
      <entry type="Comment" style="italic #${colors.base03}"/>
      <entry type="CommentSingle" style="italic #${colors.base03}"/>
      <entry type="CommentMultiline" style="italic #${colors.base03}"/>
      <entry type="CommentSpecial" style="italic #${colors.base03}"/>
      <entry type="CommentHashbang" style="italic #${colors.base03}"/>
      <entry type="CommentPreproc" style="italic #${colors.base03}"/>
      <entry type="CommentPreprocFile" style="bold #${colors.base03}"/>
      <entry type="Error" style="#${colors.base08}"/>
      <entry type="GenericError" style="#${colors.base08}"/>
      <entry type="GenericDeleted" style="#${colors.base08} bg:#${colors.base01}"/>
      <entry type="GenericInserted" style="#${colors.base0B} bg:#${colors.base01}"/>
      <entry type="GenericEmph" style="italic #${colors.base05}"/>
      <entry type="GenericStrong" style="bold #${colors.base05}"/>
      <entry type="GenericUnderline" style="underline #${colors.base05}"/>
      <entry type="GenericHeading" style="bold #${colors.base09}"/>
      <entry type="GenericSubheading" style="bold #${colors.base09}"/>
    </style>
  '';

  registerGo = pkgs.writeText "register-stylix.go" ''
    package main

    import (
      _ "embed"
      "strings"

      "github.com/alecthomas/chroma/v2"
      "github.com/alecthomas/chroma/v2/styles"
    )

    //go:embed stylix-chroma.xml
    var stylixChromaXml string

    func init() {
      style, err := chroma.NewXMLStyle(strings.NewReader(stylixChromaXml))
      if err != nil {
        panic(err)
      }
      styles.Register(style)
    }
  '';
in
{
  overlay =
    _final: prev:
    optionalAttrs
      (
        config.stylix.enable
        && config.stylix.targets ? superfile
        && config.stylix.targets.superfile.enable
      )
      {
        superfile = prev.superfile.overrideAttrs (old: {
          postPatch = (old.postPatch or "") + ''
            cp ${registerGo} ./register-stylix.go
            cp ${chromaXml} ./stylix-chroma.xml
          '';
        });
      };
}
