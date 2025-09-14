#!/usr/bin/env bash
# gum_helpers.sh
# Reusable helpers for Charm's gum across scripts.
# Source this file:  source "$(dirname "$0")/gum_helpers.sh"
# Requires: bash, gum
# License: MIT

# ANSI COLORS
ANSI_BLACK=0
ANSI_RED=1
ANSI_GREEN=2
ANSI_YELLOW=3
ANSI_BLUE=4
ANSI_MAGENTA=5
ANSI_CYAN=6
ANSI_WHITE=7

# -----------------------------
# Configuration (overridable)
# -----------------------------
: "${GUMH_COLOR_PRIMARY:=$ANSI_CYAN}"
: "${GUMH_COLOR_INFO:=$ANSI_BLUE}"
: "${GUMH_COLOR_WARN:=$ANSI_YELLOW}"
: "${GUMH_COLOR_ERROR:=$ANSI_RED}"
: "${GUMH_COLOR_DIM:=240}"         # Supports ANSI index or hex like #AAAAAA
: "${GUMH_HEADER_UNDERLINE:=1}"
: "${GUMH_HEADER_BOLD:=1}"
: "${GUMH_PROMPT_BOLD:=1}"
: "${GUMH_ERR_PREFIX:=ERROR}"
: "${GUMH_WARN_PREFIX:=WARN}"
: "${GUMH_INFO_PREFIX:=INFO}"
: "${GUMH_STRICT:=1}"              # If 1, gum missing -> non-zero return

# -----------------------------
# Internal helpers
# -----------------------------
_gumh_bool_flag() {
  # _gumh_bool_flag <value> <flag>
  # Emits flag if value is 1/true/yes
  local v="${1:-}" f="${2:-}"
  case "$v" in
    1|true|TRUE|yes|YES) printf '%s' "$f" ;;
  esac
}

_gumh_has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

_gumh_print_styled() {
  # _gumh_print_styled [gum style flags...] -- text
  local args=() text=() seen_dd=
  for a in "$@"; do
    if [[ -z "$seen_dd" && "$a" == "--" ]]; then
      seen_dd=1
      continue
    fi
    if [[ -z "$seen_dd" ]]; then
      args+=("$a")
    else
      text+=("$a")
    fi
  done
  if _gumh_has_cmd gum; then
    gum style "${args[@]}" -- "${text[*]}"
  else
    # Fallback: plain text if gum missing
    printf '%s\n' "${text[*]}"
  fi
}

# -----------------------------
# Public: requirements and theme
# -----------------------------
gumh_require() {
  if _gumh_has_cmd gum; then
    return 0
  fi
  if [[ "${GUMH_STRICT}" == "1" ]]; then
    printf '%s\n' "gum is required but was not found in PATH." >&2
    return 127
  fi
  return 0
}

# -----------------------------
# Public: styled messages
# -----------------------------
gumh_header() {
  # gumh_header "Title"
  local title="${1:-}"
  local flags=(
    --foreground="$GUMH_COLOR_PRIMARY"
  )
  if [[ "${GUMH_HEADER_BOLD}" == "1" ]]; then flags+=("--bold"); fi
  if [[ "${GUMH_HEADER_UNDERLINE}" == "1" ]]; then flags+=("--underline"); fi
  _gumh_print_styled "${flags[@]}" -- "$title"
}

gumh_subtle() {
  # Subtle/dim text
  _gumh_print_styled --foreground="$GUMH_COLOR_DIM" -- "$*"
}

gumh_info() {
  _gumh_print_styled --foreground="$GUMH_COLOR_INFO" -- \
    "[$GUMH_INFO_PREFIX]" "$*"
}

gumh_warn() {
  _gumh_print_styled --foreground="$GUMH_COLOR_WARN" -- \
    "[$GUMH_WARN_PREFIX]" "$*"
}

gumh_error() {
  _gumh_print_styled --foreground="$GUMH_COLOR_ERROR" -- \
    "[$GUMH_ERR_PREFIX]" "$*"
}

gumh_rule() {
  # Horizontal rule
  local width="${1:-60}"
  local char="${2:-─}"
  local line
  line="$(printf "%${width}s" "")"
  line="${line// /$char}"
  _gumh_print_styled --foreground="$GUMH_COLOR_DIM" -- "$line"
}

# -----------------------------
# Public: prompts and inputs
# -----------------------------
gumh_confirm() {
  # gumh_confirm "Message" [--default=(true|false)] [extra gum flags...]
  # Returns 0 if confirmed, 1 otherwise.
  gumh_require || return $?
  local msg="${1:-Are you sure?}"
  shift || true
  gum confirm "$@" --selected.foreground="$GUMH_COLOR_PRIMARY"
}

gumh_input() {
  # gumh_input "Prompt" [gum input flags...]
  # Echos the input to stdout.
  gumh_require || return $?
  local prompt="${1:-Enter value:}"
  shift || true
  local bold_flag
  bold_flag="$(_gumh_bool_flag "$GUMH_PROMPT_BOLD" "--bold")"
  gum input "$@"
}

gumh_write() {
  # gumh_write "Prompt" [gum write flags...]
  # Multi-line input. Echos content.
  gumh_require || return $?
  local prompt="${1:-Write text (Ctrl+D to finish):}"
  shift || true
  local bold_flag
  bold_flag="$(_gumh_bool_flag "$GUMH_PROMPT_BOLD" "--bold")"
  _gumh_print_styled --foreground="$GUMH_COLOR_PRIMARY" $bold_flag -- \
    "$prompt"
  gum write "$@"
}

# -----------------------------
# Public: choose and filter
# -----------------------------
# Pattern: pass gum flags first if needed, then a literal --, then items.
# Example:
#   choice="$(gumh_choose 'Pick one' -- --height 10 -- 'A' 'B' 'C')"
# Multi:
#   mapfile -t picks < <(gumh_choose_multi 'Pick many' -- -- 'A' 'B' 'C')

gumh_choose() {
  # gumh_choose "Prompt" [gum choose flags...] -- item1 item2 ...
  gumh_require || return $?
  local prompt="${1:-Choose an option:}"
  shift || true
  local flags=() items=() seen_dd=
  for a in "$@"; do
    if [[ -z "$seen_dd" && "$a" == "--" ]]; then
      seen_dd=1
      continue
    fi
    if [[ -z "$seen_dd" ]]; then
      flags+=("$a")
    else
      items+=("$a")
    fi
  done
  local bold_flag
  bold_flag="$(_gumh_bool_flag "$GUMH_PROMPT_BOLD" "--bold")"
  _gumh_print_styled --foreground="$GUMH_COLOR_PRIMARY" $bold_flag -- \
    "$prompt"
  if [[ ${#items[@]} -eq 0 ]]; then
    # If no items given, read from stdin
    gum choose "${flags[@]}"
  else
    printf '%s\n' "${items[@]}" | gum choose "${flags[@]}"
  fi
}

gumh_choose_multi() {
  # gumh_choose_multi "Prompt" [gum choose flags...] -- item1 item2 ...
  gumh_require || return $?
  # Force multi-select: gum choose --no-limit
  gumh_choose "$1" --no-limit "${@:2}"
}

gumh_filter() {
  # gumh_filter "Prompt" [gum filter flags...] -- item1 item2 ...
  # If no items provided after --, reads from stdin.
  gumh_require || return $?
  local prompt="${1:-Filter items:}"
  shift || true
  local flags=() items=() seen_dd=
  for a in "$@"; do
    if [[ -z "$seen_dd" && "$a" == "--" ]]; then
      seen_dd=1
      continue
    fi
    if [[ -z "$seen_dd" ]]; then
      flags+=("$a")
    else
      items+=("$a")
    fi
  done
  local bold_flag
  bold_flag="$(_gumh_bool_flag "$GUMH_PROMPT_BOLD" "--bold")"
  _gumh_print_styled --foreground="$GUMH_COLOR_PRIMARY" $bold_flag -- \
    "$prompt"
  if [[ ${#items[@]} -eq 0 ]]; then
    gum filter "${flags[@]}"
  else
    printf '%s\n' "${items[@]}" | gum filter "${flags[@]}"
  fi
}

# -----------------------------
# Public: spinners and tasks
# -----------------------------
gumh_spin() {
  # gumh_spin "Message" -- command [args...]
  # Runs command with a spinner. Propagates exit code.
  gumh_require || return $?
  local msg="${1:-Working...}"
  shift || true
  if [[ "${1:-}" != "--" ]]; then
    gumh_error "gumh_spin requires '--' before the command."
    return 2
  fi
  shift
  local cmd=( "$@" )
  if [[ ${#cmd[@]} -eq 0 ]]; then
    gumh_error "No command provided to gumh_spin."
    return 2
  fi
  gum spin --title "$msg" -- "${cmd[@]}"
}

# -----------------------------
# Public: formatting helpers
# -----------------------------
gumh_md() {
  # Render simple Markdown via gum format
  # Usage: gumh_md "# Title" "Some text"
  gumh_require || return $?
  gum format "$@"
}

gumh_note() {
  # A small dim note block
  local text="$*"
  _gumh_print_styled --foreground="$GUMH_COLOR_DIM" -- "$text"
}

# -----------------------------
# Demonstration (only if executed directly)
# -----------------------------
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  set -euo pipefail
  if ! gumh_require; then
    printf '%s\n' "Install gum: https://github.com/charmbracelet/gum" >&2
    exit 127
  fi

  gumh_header "gum helpers demo"
  gumh_info "This is an info message."
  gumh_warn "This is a warning."
  gumh_error "This is an error."
  gumh_rule

  name="$(gumh_input 'Your name' --placeholder 'Jane Doe')"
  gumh_info "Hello, $name!"

  if gumh_confirm "Proceed with selection?" --default=true; then
    choice="$(gumh_choose 'Pick one' -- --height 7 -- 'Alpha' 'Beta' 'Gamma')"
    gumh_info "You chose: $choice"
  else
    gumh_warn "Selection skipped."
  fi

  gumh_rule
  gumh_spin "Sleeping 1s" -- bash -c 'sleep 1'
  gumh_md "# Done" "Thanks for trying gum_helpers.sh"
fi