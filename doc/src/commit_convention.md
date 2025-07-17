# Commit convention

Stylix commit messages follow a combination of [Nixpkgs](
https://github.com/NixOS/nixpkgs/blob/master/CONTRIBUTING.md#commit-conventions)
and [Linux Kernel](https://docs.kernel.org/process/submitting-patches.html)
commit conventions:

```
«SUBSYSTEM»: «SUMMARY»

[«BODY»]

[«BREAKING_CHANGE»]

«CONTEXT_TAGS»

«CONTRIBUTION_TAGS»
```

where

| Element               | Description |
|-----------------------|-------------|
| `«SUBSYSTEM»`         | Area of patched files, optionally nested using `:` for general subsystems and `/` for paths.<br><br>For example, patching `/stylix/hm/` should be formatted as `stylix/hm` instead of `stylix: hm`, while `/stylix/*/palette.nix` should be formatted as `stylix: palette`.<br><br>Specific conventions include simplifying `modules/«MODULE»` to `«MODULE»`, `flake` encompassing `/flake.{lock,nix}` and `/flake/`, `/github/` mapping to `ci`, and `treewide` representing changes that cannot be categorized under a more specific subsystem. |
| `«SUMMARY»`           | Concise, single-line explanation of maximum 72 characters in imperative mood, starting lowercase and not ending with punctuation. |
| `«BODY»`              | Detailed, self-contained explanation of the problem, its user impact, the technical solution, and any quantified optimizations or trade-offs, focusing on one problem per patch. |
| `«BREAKING_CHANGE»`   | Dedicated `BREAKING CHANGE: «BODY»` section regarding breaking changes. |
| `«CONTEXT_TAGS»`      | Tags providing external context, such as `Closes:`, `Fixes:`, `Link:`, and `Reverts:`. |
| `«CONTRIBUTION_TAGS»` | Contribution tags for crediting contributors and indicating patch reliability, such as `Approved-by:`, `Co-authored-by:`, `Reviewed-by:`, and `Tested-by:`. |

The following examples should demonstrate everything:

- [`ci: add workflow to label merge conflicts`](
  https://github.com/nix-community/stylix/commit/46caa4122c4eacafba8e38f4b9344dd149064a10)

- [`flake: infer default.nix import path`](
  https://github.com/nix-community/stylix/commit/1baa44cf8c3a4699d0beda91f39ba7942b46269d)

- [`fontconfig: align Home Manager with NixOS and enhance docs`](
  https://github.com/nix-community/stylix/commit/6d72fc259b6f595f5bcf9634bf2f82b76f939a0d)

- [`kde: replace systemd unit with AutostartScript for theme application`](
  https://github.com/nix-community/stylix/commit/e0a41d3a2562ce1b43cad8560333673d04b111b8)

- [`stylix: do not check lambda pattern names with deadnix`](
  https://github.com/nix-community/stylix/commit/4add678fe3978177744e8af3c72a6a8a1288227b)

- [`stylix: rename homeManagerModules to homeModules`](
  https://github.com/nix-community/stylix/commit/0e5b1613bd9285700c99e5ecf0a4e31da8cb5e04)

- [`treewide: adjust notification colors to represent urgency`](
  https://github.com/nix-community/stylix/commit/a6eff346d8e346b5a8e7eb3f8f7c4b36c9597a3c)

- [`treewide: use mkEnableTargetWith for dynamic autoEnable conditions`](
  https://github.com/nix-community/stylix/commit/d73d8f6a4834716496bf8930a492b115cc3d7d17)

- [`wayfire: mixup between wayfire and wf-shell settings`](
  https://github.com/nix-community/stylix/commit/0150050d6eed373b04fd85e08bd2ae7b5cc8d3b2)

<!--
TODO: Remove this note after 26.05, giving this convention one year of
      establishment.
-->
> [!NOTE]
> `«SUBSYSTEM»` nesting is a recent convention. Consequently, examples are
> scarce.

## Maintainer Notice

When merging, add the PR ID in the commit header as `«SUBSYSTEM»: «SUMMARY»
(#«PR_ID»)`, and link the PR using the `Link:` commit tag.

Ensure all appropriate `«CONTEXT_TAGS»` and `«CONTRIBUTION_TAGS»` commit tags
are added.

Merge commits should be used to preserve valuable commit history; otherwise,
squash merge. For example, the `«module»: init` and `«module»: add testbed`
patchset should be squash merged, while more elaborate patchsets may justify a
merge commit. For simplicity, Individual commits within a merge commit do not
require `«CONTEXT_TAGS»` and `«CONTRIBUTION_TAGS»` commit tags, although the
merge commit itself must.

Automated backport PRs should be rebase merged to retain the original commit
author and leverage the automatically appended `(cherry picked from commit
«COMMIT_HASH»)` line.
