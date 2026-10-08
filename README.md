# gray-resources

Pin files as always-on context: every model request carries a synthetic user
message with the contents of your pinned files. Port of pi's
`dynamic-resources` extension.

A sidecar plugin for [gray](https://github.com/vstaln/gray), scaffolded by
[gray-account](https://github.com/vstaln/gray-account).

## What it does

A registry at `~/.gray/resources/list.json` (`{"files": ["path", …]}`,
`$GRAY_HOME` honored) lists pinned files — entries may be absolute,
`~`-relative, or session-cwd-relative.

On every `context/build` (protocol 2.0) the sidecar prepends ONE synthetic
user message to the outbound list:

```
The following files were pinned as resources:

### /abs/path/one.md
<file contents>

### /abs/path/two.md
<file contents>
```

24 KiB total cap; binary files are skipped (and marked), unreadable paths
are marked. Empty registry → `{}` (the outbound list is kept as-is).

`/resources add <path>` pins a file (dedupes, expands `~`);
`/resources rm <path>` unpins; bare `/resources` lists the registry with
resolved paths and missing-file markers.

## Wire methods

`plugin/manifest` · `context/build` (hook) · `command/run` (`/resources`) ·
`plugin/shutdown`

## Install

```sh
gray plugin install resources
```

## Develop

```sh
cargo test
gray account check      # entry point + manifest handshake
gray account publish    # check → build → release → publish to the gray registry
```

Bump `version` in `Cargo.toml` before each `publish`; the registry refuses to
republish a version.
