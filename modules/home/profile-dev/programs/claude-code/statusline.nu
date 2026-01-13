#!/usr/bin/env nu

def main [] {
  let input = $in | from json
  let cwd = $input.workspace.current_dir
  let model_name = $input.model.display_name
  let version = $input.version? | default "-"
  let total_in = $input.context_window.total_input_tokens
  let total_out = $input.context_window.total_output_tokens
  let usage = $input.context_window.current_usage?
  let size = $input.context_window.context_window_size

  # Git branch
  let git_branch = if (git -C $cwd rev-parse --git-dir | complete).exit_code == 0 {
    let branch = (git -C $cwd branch --show-current | str trim)
    if $branch != "" { $" (ansi {fg: '#ffafd7'})($branch)(ansi reset)" } else { "" }
  } else { "" }

  # Context percentage
  let ctx = if $usage != null {
    let current = $usage.input_tokens + $usage.cache_creation_input_tokens + $usage.cache_read_input_tokens
    let pct = ($current * 100 / $size)
    $"(ansi yellow)ctx:($pct)%(ansi reset)"
  } else { "" }

  # Format tokens
  let in_fmt = if $total_in >= 1000 { $"($total_in / 1000)K" } else { $"($total_in)" }
  let out_fmt = if $total_out >= 1000 { $"($total_out / 1000)K" } else { $"($total_out)" }

  let model_str = $"(ansi cyan)<($model_name)>(ansi reset)"
  let ctx_str = $"(ansi blue)[ctx: ($ctx)](ansi reset)"
  let in_str = $"(ansi green_dimmed)[in: ($in_fmt)](ansi reset)"
  let out_str = $"(ansi green_dimmed)[out: ($out_fmt)](ansi reset)"
  let ver_str = $"(ansi dark_gray)v($version)(ansi reset)"

  print -n $"($model_str) ($cwd)($git_branch) ($ctx_str) ($in_str) ($out_str) ($ver_str)"
}
