{ colors }:
with colors;
''
  /* Common variables affecting all pages */
  @-moz-document url-prefix("about:") {
    :root {
      --in-content-page-color: #${base05-hex} !important;
      --color-accent-primary: #${base0D-hex} !important;
      --color-accent-primary-hover: #${base0D-hex} !important;
      --color-accent-primary-active: #${base0D-hex} !important;
      background-color: #${base00-hex} !important;
      --in-content-page-background: #${base00-hex} !important;
    }
  }

  /* Variables and styles specific to about:newtab and about:home */
  @-moz-document url("about:newtab"), url("about:home") {

    :root {
      --newtab-background-color: #${base00-hex} !important;
      --newtab-background-color-secondary: #${base02-hex} !important;
      --newtab-element-hover-color: #${base02-hex} !important;
      --newtab-text-primary-color: #${base05-hex} !important;
      --newtab-wordmark-color: #${base05-hex} !important;
      --newtab-primary-action-background: #${base0D-hex} !important;
    }

    .icon {
      color: #${base0D-hex} !important;
    }

    .search-wrapper .logo-and-wordmark .logo {
      display: inline-block !important;
      height: 82px !important;
      width: 82px !important;
      background-size: 82px !important;
    }

    @media (max-width: 609px) {
      .search-wrapper .logo-and-wordmark .logo {
        background-size: 64px !important;
        height: 64px !important;
        width: 64px !important;
      }
    }

    .card-outer:is(:hover, :focus, .active):not(.placeholder) .card-title {
      color: #${base0D-hex} !important;
    }

    .top-site-outer .search-topsite {
      background-color: #${base0D-hex} !important;
    }

    .compact-cards .card-outer .card-context .card-context-icon.icon-download {
      fill: #${base0B-hex} !important;
    }
  }

  /* Variables and styles specific to about:preferences */
  @-moz-document url-prefix("about:preferences") {
    :root {
      --zen-colors-tertiary: #${base01-hex} !important;
      --in-content-text-color: #${base05-hex} !important;
      --link-color: #${base0D-hex} !important;
      --link-color-hover: #${base0D-hex} !important;
      --zen-colors-primary: #${base02-hex} !important;
      --in-content-box-background: #${base02-hex} !important;
      --zen-primary-color: #${base0D-hex} !important;
    }

    groupbox , moz-card{
      background: #${base00-hex} !important;
    }

    button,
    groupbox menulist {
      background: #${base02-hex} !important;
      color: #${base05-hex} !important;
    }

    .main-content {
      background-color: #${base00-hex} !important;
    }

    .identity-color-blue {
      --identity-tab-color: #${base0D-hex} !important;
      --identity-icon-color: #${base0D-hex} !important;
    }

    .identity-color-turquoise {
      --identity-tab-color: #${base0C-hex} !important;
      --identity-icon-color: #${base0C-hex} !important;
    }

    .identity-color-green {
      --identity-tab-color: #${base0B-hex} !important;
      --identity-icon-color: #${base0B-hex} !important;
    }

    .identity-color-yellow {
      --identity-tab-color: #${base0A-hex} !important;
      --identity-icon-color: #${base0A-hex} !important;
    }

    .identity-color-orange {
      --identity-tab-color: #${base09-hex} !important;
      --identity-icon-color: #${base09-hex} !important;
    }

    .identity-color-red {
      --identity-tab-color: #${base08-hex} !important;
      --identity-icon-color: #${base08-hex} !important;
    }

    .identity-color-pink {
      --identity-tab-color: #${base0E-hex} !important;
      --identity-icon-color: #${base0E-hex} !important;
    }

    .identity-color-purple {
      --identity-tab-color: #${base0F-hex} !important;
      --identity-icon-color: #${base0F-hex} !important;
    }

  /* Variables and styles specific to about:addons */
  @-moz-document url-prefix("about:addons") {
    :root {
      --zen-dark-color-mix-base: #${base01-hex} !important;
      --background-color-box: #${base00-hex} !important;
    }
  }

  /* Variables and styles specific to about:protections */
  @-moz-document url-prefix("about:protections") {
    :root {
      --zen-primary-color: #${base00-hex} !important;
      --social-color: #${base0E-hex} !important;
      --coockie-color: #${base0D-hex} !important;
      --fingerprinter-color: #${base0A-hex} !important;
      --cryptominer-color: #${base0F-hex} !important;
      --tracker-color: #${base0B-hex} !important;
      --in-content-primary-button-background-hover: #${base03-hex} !important;
      --in-content-primary-button-text-color-hover: #${base05-hex} !important;
      --in-content-primary-button-background: #${base03-hex} !important;
      --in-content-primary-button-text-color: #${base05-hex} !important;
    }

    .card {
      background-color: #${base02-hex} !important;
    }
  }
''
