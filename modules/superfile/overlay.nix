{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) optionalAttrs;
  inherit (config.lib.stylix) colors;

  chromaXml =
    with colors.withHashtag;
    pkgs.writeText "stylix-chroma.xml" ''
      <style name="stylix">
        <entry type="Background" style="bg:${base00}"/>
        <entry type="LineHighlight" style="bg:${base02}"/>
        <entry type="LineNumbers" style="${base04}"/>
        <entry type="LineNumbersTable" style="${base04}"/>
        <entry type="LineTableTD" style=""/>
        <entry type="LineTable" style=""/>
        <entry type="CodeLine" style="${base05}"/>
        <entry type="Text" style="${base05}"/>
        <entry type="Punctuation" style="${base05}"/>
        <entry type="TextWhitespace" style="${base05}"/>
        <entry type="Other" style="${base05}"/>
        <entry type="Name" style="${base05}"/>
        <entry type="NameOther" style="${base05}"/>
        <entry type="NameConstant" style="${base0A}"/>
        <entry type="NameDecorator" style="bold ${base0D}"/>
        <entry type="NameEntity" style="${base0C}"/>
        <entry type="NameException" style="${base09}"/>
        <entry type="NameNamespace" style="${base09}"/>
        <entry type="Literal" style="${base05}"/>
        <entry type="LiteralDate" style="${base05}"/>
        <entry type="Generic" style="${base05}"/>
        <entry type="GenericOutput" style="${base05}"/>
        <entry type="GenericPrompt" style="${base05}"/>
        <entry type="GenericStrong" style="${base05}"/>
        <entry type="GenericTraceback" style="${base05}"/>
        <entry type="Keyword" style="${base0E}"/>
        <entry type="KeywordReserved" style="${base0E}"/>
        <entry type="KeywordPseudo" style="${base0E}"/>
        <entry type="KeywordConstant" style="${base09}"/>
        <entry type="KeywordDeclaration" style="${base08}"/>
        <entry type="KeywordNamespace" style="${base0C}"/>
        <entry type="KeywordType" style="${base08}"/>
        <entry type="NameFunction" style="${base0D}"/>
        <entry type="NameFunctionMagic" style="${base0D}"/>
        <entry type="NameAttribute" style="${base0D}"/>
        <entry type="NameClass" style="${base0A}"/>
        <entry type="NameBuiltin" style="${base0C}"/>
        <entry type="NameBuiltinPseudo" style="${base0C}"/>
        <entry type="NameLabel" style="${base0C}"/>
        <entry type="NameVariable" style="${base05}"/>
        <entry type="NameVariableClass" style="${base05}"/>
        <entry type="NameVariableGlobal" style="${base05}"/>
        <entry type="NameVariableInstance" style="${base05}"/>
        <entry type="NameVariableMagic" style="${base05}"/>
        <entry type="NameProperty" style="${base09}"/>
        <entry type="NameTag" style="${base0E}"/>
        <entry type="LiteralString" style="${base0B}"/>
        <entry type="LiteralStringChar" style="${base0B}"/>
        <entry type="LiteralStringSingle" style="${base0B}"/>
        <entry type="LiteralStringDouble" style="${base0B}"/>
        <entry type="LiteralStringBacktick" style="${base0B}"/>
        <entry type="LiteralStringOther" style="${base0B}"/>
        <entry type="LiteralStringSymbol" style="${base0B}"/>
        <entry type="LiteralStringInterpol" style="${base0B}"/>
        <entry type="LiteralStringHeredoc" style="${base04}"/>
        <entry type="LiteralStringDoc" style="${base04}"/>
        <entry type="LiteralStringEscape" style="${base0C}"/>
        <entry type="LiteralStringRegex" style="${base0C}"/>
        <entry type="LiteralStringDelimiter" style="${base0D}"/>
        <entry type="LiteralStringAffix" style="${base0E}"/>
        <entry type="LiteralNumber" style="${base09}"/>
        <entry type="LiteralNumberBin" style="${base09}"/>
        <entry type="LiteralNumberHex" style="${base09}"/>
        <entry type="LiteralNumberInteger" style="${base09}"/>
        <entry type="LiteralNumberFloat" style="${base09}"/>
        <entry type="LiteralNumberIntegerLong" style="${base09}"/>
        <entry type="LiteralNumberOct" style="${base09}"/>
        <entry type="Operator" style="bold ${base0C}"/>
        <entry type="OperatorWord" style="bold ${base0C}"/>
        <entry type="Comment" style="italic ${base03}"/>
        <entry type="CommentSingle" style="italic ${base03}"/>
        <entry type="CommentMultiline" style="italic ${base03}"/>
        <entry type="CommentSpecial" style="italic ${base03}"/>
        <entry type="CommentHashbang" style="italic ${base03}"/>
        <entry type="CommentPreproc" style="italic ${base03}"/>
        <entry type="CommentPreprocFile" style="bold ${base03}"/>
        <entry type="Error" style="${base08}"/>
        <entry type="GenericError" style="${base08}"/>
        <entry type="GenericDeleted" style="${base08} bg:${base01}"/>
        <entry type="GenericInserted" style="${base0B} bg:${base01}"/>
        <entry type="GenericEmph" style="italic ${base05}"/>
        <entry type="GenericStrong" style="bold ${base05}"/>
        <entry type="GenericUnderline" style="underline ${base05}"/>
        <entry type="GenericHeading" style="bold ${base09}"/>
        <entry type="GenericSubheading" style="bold ${base09}"/>
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
          postPatch = ''
            ${old.postPatch or ""}

            cp ${registerGo} ./register-stylix.go
            cp ${chromaXml} ./stylix-chroma.xml
          '';
        });
      };
}
