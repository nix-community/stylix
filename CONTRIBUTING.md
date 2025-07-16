# Contributing to Stylix

This guide provides the information necessary to contribute to Stylix.

## Commit convention

To keep things consistent, commit messages should follow a format
[similar to Nixpkgs](https://github.com/NixOS/nixpkgs/blob/master/CONTRIBUTING.md#commit-conventions):

```
«scope»: «summary»

«motivation for change»
```

Where the scope is one of:

| Scope          | Purpose                                                          |
|----------------|------------------------------------------------------------------|
| `ci`           | Changes to GitHub Actions workflows.                             |
| `doc`          | Changes to the website, `README.md`, and so on.                  |
| `flake`        | Changes in the `flake` directory, `flake.nix`, and `flake.lock`. |
| `stylix`       | Changes in the `stylix` directory and other global code.         |
| Name of target | Changes to code for a particular target.                         |
| `treewide`     | Changes across many targets.                                     |

The scope is meant to indicate which area of the code was changed. Specifying
the type of change, such as `feat` or `fix`, is not necessary. Dependency
updates should use whichever scope they are related to.

The summary should start with a lowercase letter, and should not end with
punctuation.

Most commits to `master` will also include a pull request number in brackets
after the summary. GitHub adds this automatically when creating a squash merge.

## Adding modules

### Development setup

Currently the easiest way to test Stylix is to use the new code in your actual
configuration.

You might find it useful to override Stylix' input flake reference on your
flake, from `github:nix-community/stylix` to
`git+file:/home/user/path/to/stylix`, so that you don't need to push changes to
GitHub during testing.

To do that, instead of editing your `flake.nix`, you can leverage `nix`'
`--override-input` parameter (which can also be supplied through their
frontends: `nixos-rebuild`, `nix-on-droid` and even `nh`). It allows you to
deploy your changes in one fell swoop, without having to update the lock file of
your flake every time you make an edit.

Just append `--override-input stylix git+file:/home/user/path/to/stylix` to your
standard `nix` (or `nix` frontend) incantation.

Nix only reads files which are tracked by Git, so you also need to `git add
«file»` after creating a new file.

### Module naming

Modules should be named like `modules/«name»/«platform».nix`. For example,
`modules/avizo/hm.nix` is a Home Manager module which themes Avizo.

The following platforms are supported:

- NixOS (`nixos`)
- Home Manager (`hm`)
- Nix-Darwin (`darwin`)
- Nix-on-Droid (`droid`)

Correctly named modules will be imported automatically.

Other files needed by the module can also be stored within the `modules/«name»`
folder, using any name which is not on the list above.

### Module template

Modules should be created using the `mkTarget` function whenever possible (see
the [`/stylix/mk-target.nix`](
https://github.com/danth/stylix/blob/-/stylix/mk-target.nix) in-source
documentation for more details):

```nix
{ config, lib, mkTarget ... }:
mkTarget {
  name = "«name»";
  humanName = "«human readable name»";

  configElements =
    { colors }:
    {
      programs.«name».theme.background = colors.base00;
    };
}
```

> [!IMPORTANT]
> The `mkTarget` argument is only available to modules imported by Stylix's
> [autoload system](https://github.com/danth/stylix/blob/-/stylix/autoload.nix),
> e.g., `modules/«target»/«platform».nix` modules.
>
> I.e., it is not available to normal modules imported via the `imports` list.

When the `mkTarget` function cannot be used, modules must manually replicate its
safeguarding behaviour:

```nix
{ config, lib, ... }:
{
  options.stylix.targets.«name».enable =
    config.lib.stylix.mkEnableTarget "«human readable name»" true;

  config =
    lib.mkIf (config.stylix.enable && config.stylix.targets.«name».enable)
      {
        programs.«name».backgroundColor = config.lib.stylix.colors.base00;
      };
}
```

> [!CAUTION]
> If not using `mkTarget`, you **must** check _both_ `config.stylix.enable`
> _and_ your target's own`enable` option before defining any config.
>
> In the above example this is done using
> `config = lib.mkIf (config.stylix.enable && config.stylix.targets.«name».enable)`.

The human readable name will be inserted into the following sentence:

> Whether to enable theming for «human readable name».

If your module will touch options outside of `programs.«name»` or
`services.«name»`, it should include an additional condition in `mkIf` to
prevent any effects when the target is not installed.

The boolean value after `mkEnableTarget` should be changed to `false` if one of
the following applies:

- The module requires further manual setup to work correctly.
- There is no reliable way to detect whether the target is installed, *and*
enabling it unconditionally would cause problems.

> [!CAUTION]
> The boolean value after `mkEnableTarget` should usually be a static `true` or
> `false` literal.
>
> Using a dynamic value requires you to document the dynamic expression using
> `mkEnableTargetWith`'s `autoEnableExpr` argument.

#### Overlays

If your module is provided as an overlay it uses a special format, where config
is transparently passed to the platform (e.g. nixos) and overlay is a function
taking two arguments and returning an attrset:

```nix
{
  lib,
  config,
  ...
}:
{
  options.stylix.targets.«name».enable =
    config.lib.stylix.mkEnableTarget "«human readable name»" true;

  overlay =
    final: prev:
    lib.optionalAttrs
      (config.stylix.enable && config.stylix.targets.«name».enable)
      {
        «name» = prev.«name».overrideAttrs (oldAttrs: {

        });
      };
}
```

### How to apply colors

Refer to the [style guide](#style-guide) to see how colors are named, and where
to use each one.

The colors are exported under `config.lib.stylix.colors`, which originates from
[`mkSchemeAttrs`](https://github.com/SenchoPens/base16.nix/blob/main/DOCUMENTATION.md#mkschemeattrs).

You can use the values directly:

```nix
{
  environment.variables.MY_APPLICATION_COLOR = config.lib.stylix.colors.base05;
}
```

Or you can create a [Mustache](http://mustache.github.io) template and use
it as a function. This returns a derivation which builds the template.

```nix
{ config, ... }:
{
  environment.variables.MY_APPLICATION_CONFIG_FILE =
    let
      configFile = config.lib.stylix.colors {
        template = ./config.toml.mustache;
        extension = ".toml";
      };
    in
    "${configFile}";
}
```

Setting options through an existing NixOS or Home Manager module is preferable
to generating whole files, since users will have the option of overriding things
individually.

Also note that reading generated files with `builtins.readFile` can be very slow
and should be avoided.

### How to apply other things

For everything else, like fonts and wallpapers, you can just take option values
directly from `config`. See the reference pages for a list of options.

### Metadata

Metadata is stored in `/modules/«module»/meta.nix`. The following attributes are
available under `meta`:

- `name`: required human-readable string name.

- `homepage`: homepage string or attribute set of homepage strings, depending
  on the number of homepages:

  - ```nix
    homepage = "https://github.com/nix-community/stylix";
    ```

  - ```nix
    homepage = {
      Nix = "https://github.com/NixOS/nix";
      Nixpkgs = "https://github.com/NixOS/nixpkgs";
    };
    ```

  The attribute names are used as hyperlink text and the attribute values are
  used as URLs.

- `maintainers`: required list of maintainers. See [Maintainers](#maintainers)
  section.

- `description`: optional markdown string for extra documentation.

#### Maintainers

New modules must have at least one maintainer.

If you are not already listed in the Nixpkgs `/maintainers/maintainer-list.nix`
maintainer list, add yourself to `/stylix/maintainers.nix`.

Add yourself as a maintainer in one of the following ways, depending on the
number of maintainers:

- ```nix
  { lib, ... }:
  {
    maintainers = [ lib.maintainers.danth ];
  }
  ```

- ```nix
  { lib, ... }:
  {
    maintainers = with lib.maintainers; [
      danth
      naho
    ];
  }
  ```

The main responsibility of module maintainers is to update and fix their
modules.

### Documentation

Documentation for options is automatically generated. To improve the quality of
this documentation, ensure that any custom options created using `mkOption` are
given an appropriate `type` and a detailed `description`. This may use Markdown
syntax for formatting and links.

For modules needing more general documentation, add a `description` to
`modules/«module»/meta.nix`:

```nix
description = ''
  Consider describing which applications are themed by this module (if it's not
  obvious from the module name), how the applications need to be installed for
  the module to work correctly, which theming items are supported (colors,
  fonts, wallpaper, ...), and any caveats the user should be aware of.
'';
```

This will be inserted before the automatically generated list of options.

You can build and view the documentation by running `nix run .#doc`, which will
build the documentation, start a localhost web-server, and open it in your
browser.

See also: [Development environment → Documentation](#documentation-1)

### Common Mistakes

#### `home.activation` Scripts

Any script run by `home.activation` must be preceded by `run` if the script is
to produce any permanent changes. Without this `run` wrapper, the script is run
in dry-run mode.

## Testbeds

Stylix provides a suite of virtual machines which can be used to test and
preview themes without installing the target to your live system.

These can be particularly helpful for:

- Working on targets before the login screen, since you can avoid closing your
editor to see the result.
- Developing for a different desktop environment than the one you normally use.
- Reducing the risk of breaking your system while reviewing pull requests.

Testbeds are also built by GitHub Actions for every pull request. This is less
beneficial compared to running them yourself, since it cannot visually check the
theme, however it can catch build failures which may have been missed otherwise.

### Creation

Testbeds are defined at `/modules/«module»/testbeds/«testbed».nix` and are are
automatically loaded as a NixOS module with options such as `stylix.image`
already defined. The testbed should include any options necessary to install the
target and any supporting software - for example, a window manager.

#### Special Options

Testbeds are given a special set of options which configure for common testbed
uses.

- `config.stylix.testbed`
  - `enable` defaults to true; allows for conditionally disabling a testbed
  - `ui` and all of its suboptions are optional. Setting any will enable a
    graphical environment.
    - `command` takes a command to be run once the graphical environment
      has loaded
      - `text` takes the string of the command
      - `useTerminal` takes a boolean which determines whether the command
        should be run in a terminal
    - `application` takes a desktop application to be run once the graphical
      environment has loaded. If one of its suboptions is set, all must be.
      - `name` takes the string name of the desktop application
      - `package` takes the package which provides the `.desktop` file

#### Home Manager

If the target can only be used through Home Manager, you can write a Home
Manager module within the NixOS module using the following format:

```nix
{ lib, ... }:
{
  home-manager.sharedModules = lib.singleton {
    # Write Home Manager options here
  };
}
```

Using `home-manager.sharedModules` is preferred over `home-manager.users.guest`
since it allows us to easily change the username or add additional users in the
future.

Once the module is complete, use `git add` to track the file, then the new
packages will be [available to use](#usage).

### Usage

You can list the available testbeds by running this command from anywhere within
the repository:

```console
user@host:~$ nix flake show
github:nix-community/stylix
└───packages
    └───x86_64-linux
        ├───doc: package 'stylix-book'
        ├───palette-generator: package 'palette-generator'
        ├───"testbed:gnome:cursorless": package 'testbed-gnome-cursorless'
        ├───"testbed:gnome:dark": package 'testbed-gnome-dark'
        ├───"testbed:gnome:imageless": package 'testbed-gnome-imageless'
        ├───"testbed:gnome:light": package 'testbed-gnome-light'
        ├───"testbed:gnome:schemeless": package 'testbed-gnome-schemeless'
        ├───"testbed:kde:cursorless": package 'testbed-kde-cursorless'
        ├───"testbed:kde:dark": package 'testbed-kde-dark'
        ├───"testbed:kde:imageless": package 'testbed-kde-imageless'
        ├───"testbed:kde:light": package 'testbed-kde-light'
        └───"testbed:kde:schemeless": package 'testbed-kde-schemeless'
```

(This has been edited down to only the relevant parts.)

To start a testbed, each of which is named in the format
`testbed:«module»:«testcase»`, run the following command:

```console
user@host:~$ nix run .#testbed:«module»:«testcase»
```

Any package with a name not fitting the given format is not a testbed, and may
behave differently with this command, or not work at all.

Once the virtual machine starts, a window should open, similar to the screenshot
below. The contents of the virtual machine will vary depending on the target you
selected earlier.

![GDM login screen with a dark background color and showing a guest user](testbed_gnome_default_dark.png)

If the testbed includes a login screen, the guest user should log in
automatically when selected. Depending on the software used, you may still be
presented with a password prompt - in which case you can leave it blank and
proceed by pressing enter.

## Development environment

### Developer shell

To enter the developer shell, run:

```sh
nix develop
```

To automatically enter the developer shell upon entering the project directory
with [`direnv`](https://direnv.net), run:

```sh
direnv allow
```

### `pre-commit`

The default developer shell leverages [`pre-commit`](https://pre-commit.com)
hooks to simplify the process of reaching minimum quality standards for casual
contributors. This means applying code formatters, and scanning for things like
unused variables which should be removed.

By default, once you have entered the developer shell, `pre-commit` runs
automatically just before you create a commit. This will only look at the files
which are about to be committed.

You can also run it manually against all files:

```sh
pre-commit run --all-files
```

This is useful if a commit was created outside of the developer shell, and you
need to apply `pre-commit` to your previous changes.

Note that there is also a flake output, `.#checks.«system».git-hooks`, which
always runs against all files but does not have access to apply changes. This is
used in GitHub Actions to ensure that `pre-commit` has been applied.

### `stylix-check`

When a pull request is opened, we use GitHub Actions to build everything under
`.#checks`. This includes the previously mentioned
`.#checks.«system».git-hooks`, and every [testbed](./contributing.md##testbeds).

You might sometimes find it useful to run these same checks locally. The built
in `nix flake check` command does this, however it can be quite slow compared to
the script we use on GitHub Actions.

To use the same script that we use, you can run this command within the
developer shell:

```sh
stylix-check
```

This is based on [`nix-fast-build`](https://github.com/Mic92/nix-fast-build#readme).


### Documentation

The documentation in the `doc` subtree gets
[published](https://nix-community.github.io/stylix) automatically, using GitHub
Actions.

If you modify it, you can easily build it and check your changes locally:

```sh
nix run .#doc
```

This will build the documentation, start a localhost web-server, and open it in
your browser.

See also: [Adding modules → Documentation](#documentation)

## Style guide

The [base16 style guide](https://github.com/chriskempson/base16/blob/main/styling.md)
is generally targeted towards text editors. Stylix aims to support a variety of
other applications, and as such it requires its own guide to keep colours
consistent. Towards this goal we will define several common types of
applications and how to style each of them using the available colours.

Please keep in mind that this is a general guide; there will be several
applications that don't fit into any of the groups below. In this case it is up
to the committer to make sure said application fits in stylistically with the
rest of the themed applications.

It is also important to note that this is a growing theming guide and when
theming an application and you find the guide to be lacking in any way in terms
of direction, you are encouraged to open an issue regarding what you would like
to see added to the style guide.

### Terms

#### Alternate

An alternate color should be used when something needs to look separate while
not being drastically different. The smaller or less common element should use
the alternate color.

![Appearance tab in GNOME settings](https://github.com/SomeGuyNamedMy/stylix/assets/28959268/e29f9fec-7b68-45ce-95ef-90d8e787c991)

For example, each section in this settings menu uses the alternate background
color to separate it from the rest of the window, which is using the default
background.

#### On/Off

This is for toggles or simple status indicators which have an obvious on and off
state.

![Toggles in GNOME quick settings](https://github.com/SomeGuyNamedMy/stylix/assets/28959268/710056f6-26f7-47d4-bd2f-1384185fb46a)

In the screenshot above the Wired and Night Light buttons are on, Power Mode is
off.

#### Lists and selections

A list of items to select between, such as tabs in a web browser. The selection
is the currently active item, or there could be multiple selected depending on
the use case.

![Sidebar of Nautilus file manager](https://github.com/SomeGuyNamedMy/stylix/assets/28959268/3b893677-75e1-4190-b3ab-b07d10930b19)

### General colors

- Default background: base00
- Alternate background: base01
- Selection background: base02
- Default text: base05
- Alternate text: base04
- Warning: base0A
- Urgent: base09
- Error: base08

### Window Managers

Window Managers arrange windows and provide decorations like title bars and
borders. Examples include Sway and i3.

This does not include applications bundled with the desktop environment such as
file managers, which would fall into the general category. Desktop helpers such
as taskbars and menus are not technically part of the window manager, although
they're often configured in the same place.

An urgent window is one which is grabbing for attention - Windows shows this by
a flashing orange taskbar icon.

- Unfocused window border: base03
- Focused window border: base0D
- Unfocused window border in group: base03
- Focused window border in group: base0D
- Urgent window border: base08
- Window title text: base05

### Notifications and Popups

Notifications and popups are any application overlay intended to be displayed
over other applications. Examples include the mako notification daemon and
avizo.

- Window border: base0D
- Background color: base00
- Text color: base05
- High urgency border color: base08
- Low urgency border color: base03
- Incomplete part of progress bar: base01
- Complete part of progress bar: base02

### Desktop Helpers

Applications that fall under this group are applications that complement the
window management facilities of whatever window manager the user is using.
Examples of this include waybar and polybar, as well as the similar programs
that are part of KDE and GNOME.

#### Light text color widgets

Refer to general colors above.

#### Dark text color widgets

These widgets use a different text color than usual to ensure it's still
readable when the background is more vibrant.

- Default text color: base00
- Alternate text color: base01
- Item on background color: base0E
- Item off background color: base0D
- Alternate item on background color: base09
- Alternate item off background color: base02
- List unselected background: base0D
- List selected background: base03

### Images

For creating modified versions of logos, icons, etc; where we would rather the
colors be similar to the original.

Note that the colors provided by the scheme won't necessarily match the names
given below, although most handmade schemes do.

- Background color: base00
- Alternate background color: base01
- Main color: base05
- Alternate main color: base04
- Red: base08
- Orange: base09
- Yellow: base0A
- Green: base0B
- Cyan: base0C
- Blue: base0D
- Purple: base0E
- Brown: base0F

![Recolored systemd logo](https://github.com/SomeGuyNamedMy/stylix/assets/28959268/00ba9b23-c7eb-4cbf-9f3d-aa8de159d6dd)

Example of a modified systemd logo. The square brackets are using the main
color, which is usually be white or black depending on the polarity of the
scheme.

### Text Editors/Viewers

Text editors are any application that can view or edit source code. Examples
include vim, helix, and bat.

For these please refer to the official [base16 style guide](https://github.com/chriskempson/base16/blob/main/styling.md).
