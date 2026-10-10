<div align="center">
  <img alt="gray-resources" src="assets/icon.svg" width="120" height="120" />
  <h1>gray-resources</h1>
  <p><strong>Pin files as always-on context for every request.</strong></p>
  <p>
    <a href="https://gray.alignment.id">Website</a> ·
    <a href="https://gray.alignment.id/plugins/gray-resources">Store</a> ·
    <a href="https://github.com/vstaln/gray-resources">Source</a> ·
    <a href="https://github.com/vstaln/gray">gray</a>
  </p>
  <p>
    <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-1c1c20?style=flat-square&labelColor=0a0a0b" /></a>
    <a href="https://www.rust-lang.org"><img alt="Built with Rust" src="https://img.shields.io/badge/built%20with-rust-1c1c20?style=flat-square&labelColor=0a0a0b&logo=rust&logoColor=d4a373" /></a>
    <a href="https://gray.alignment.id/plugins/gray-resources"><img alt="gray plugin" src="https://img.shields.io/badge/gray-plugin-1c1c20?style=flat-square&labelColor=0a0a0b&color=7aa2f7" /></a>
  </p>
</div>

<br/>

```bash
gray plugin install gray-resources
```

Keep a registry of pinned files and inject their contents into the model's
context automatically.

## What it does

A registry at `~/.gray/resources/list.json` (`{"files": ["path", …]}`,
`$GRAY_HOME` honored) lists pinned files. Entries may be absolute,
`~`-relative, or session-cwd-relative.

On every `context/build` (protocol 2.0), the sidecar prepends one synthetic
user message to the outbound list:

```
The following files were pinned as resources:

### /abs/path/one.md
<file contents>

### /abs/path/two.md
<file contents>
```

The combined content is capped at 24 KiB. Binary files are skipped and
marked; unreadable paths are marked. An empty registry returns `{}` and
leaves the outbound list unchanged.

`/resources add <path>` pins a file (deduped, `~` expanded);
`/resources rm <path>` unpins it; bare `/resources` lists resolved paths and
missing-file markers.

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

## Tags

`gray` `plugin` `resources` `rust`

---
Part of the [gray](https://github.com/vstaln/gray) plugin ecosystem —
the open-source AI agent harness. <https://gray.alignment.id>
