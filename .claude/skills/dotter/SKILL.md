---
name: dotter
description: Dotter (dotfile manager) の設定パターンと罠。dotter/global.toml を編集するときに参照する。
---

# Dotter

Config: `dotter/global.toml`

## Per-file type override

`[default.files]` 内で inline table を使う:

```toml
[default.files]
"source/path" = { target = "~/target/path", type = "template" }
```

Types: `"symbolic"`, `"template"` (= copy), `"automatic"`

Per-file entry は親ディレクトリのマッピングより優先される。

## Pitfalls

- inline table エントリは `[default.files]` セクション内に置くこと。空行で区切ると TOML 的にセクション外扱いになり `FileTargetOuterRepr` デシリアライズエラーで落ちる。
