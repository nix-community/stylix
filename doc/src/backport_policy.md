# Backport Policy

The backport policy defines what changes from the unstable (master) branch are
applied to the current stable (`release-*.*`) branch.

To reduce maintenance efforts and improve stability on stable branches, security
fixes, bug fixes, and CI changes are backported, while new features, modules,
and theme improvements are not backported. Upstream changes rendering themes
unreadable are considered a bug.

New modules and theme improvements may be backported when explicitly requested
and backporting is trivial.
