#!/bin/bash
# ==========================================================
#  script.sh — a pure Bash implementation of greps
#  Author: Davinci 
# ==========================================================

show_help() {
cat << EOF
Usage: $0 [OPTIONS] PATTERN [FILE...]
Options:
  -i              Ignore case
  -v              Invert match
  -c              Count of matching lines
  -n              Show line numbers
  -r              Recursive search
  -l              List files with matches
  -L              List files without matches
  -w              Match whole words
  -x              Match whole lines
  -m NUM          Limit number of matches
  -A NUM          Print NUM lines after match
  -B NUM          Print NUM lines before match
  -C NUM          Print NUM lines around match
  --color         Highlight matches
  --include=GLOB  Search only files matching pattern
  --exclude=GLOB  Skip files matching pattern
  --exclude-dir=D Skip directories named D
  --help          Show this help and exit
  --version       Show version info and exit
EOF
exit 0
}

show_version() {
  echo "mygrep (Bash Grep Clone) v1.0 — by Solomon Onyango Ndeda"
  exit 0
}

# --- Default values ---
IGNORE_CASE=false
INVERT=false
COUNT=false
NUMBER=false
RECURSIVE=false
LIST_MATCH=false
LIST_NO_MATCH=false
WHOLE_WORD=false
WHOLE_LINE=false
COLOR=false
LIMIT_MATCHES=0
AFTER=0
BEFORE=0
CONTEXT=0
INCLUDE_GLOB=""
EXCLUDE_GLOB=""
EXCLUDE_DIR=""

# --- Parse arguments ---
args=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    -i) IGNORE_CASE=true ;;
    -v) INVERT=true ;;
    -c) COUNT=true ;;
    -n) NUMBER=true ;;
    -r) RECURSIVE=true ;;
    -l) LIST_MATCH=true ;;
    -L) LIST_NO_MATCH=true ;;
    -w) WHOLE_WORD=true ;;
    -x) WHOLE_LINE=true ;;
    -m) LIMIT_MATCHES=$2; shift ;;
    -A) AFTER=$2; shift ;;
    -B) BEFORE=$2; shift ;;
    -C) CONTEXT=$2; shift ;;
    --color) COLOR=true ;;
    --include=*) INCLUDE_GLOB="${1#*=}" ;;
    --exclude=*) EXCLUDE_GLOB="${1#*=}" ;;
    --exclude-dir=*) EXCLUDE_DIR="${1#*=}" ;;
    --help) show_help ;;
    --version) show_version ;;
    -*)
      echo "Unknown option: $1"
      show_help ;;
    *)
      args+=("$1") ;;
  esac
  shift
done

if [ ${#args[@]} -eq 0 ]; then
  echo "Error: No pattern provided."
  show_help
fi

PATTERN="${args[0]}"
FILES=("${args[@]:1}")

# Case-insensitive setting
if $IGNORE_CASE; then
  shopt -s nocasematch
else
  shopt -u nocasematch
fi

# Recursive file discovery
if $RECURSIVE; then
  if [ ${#FILES[@]} -eq 0 ]; then
    FILES=(".")
  fi

  FOUND_FILES=()
  while IFS= read -r -d '' f; do
    FOUND_FILES+=("$f")
  done < <(find "${FILES[@]}" -type f \
    ${EXCLUDE_DIR:+-not -path "*/$EXCLUDE_DIR/*"} \
    ${INCLUDE_GLOB:+-name "$INCLUDE_GLOB"} \
    ${EXCLUDE_GLOB:+-not -name "$EXCLUDE_GLOB"} -print0)

  FILES=("${FOUND_FILES[@]}")
fi

# If no files, use stdin
if [ ${#FILES[@]} -eq 0 ]; then
  FILES=("-")
fi

total_matches=0

# --- Main loop ---
for file in "${FILES[@]}"; do
  [ "$file" != "-" ] && [ ! -r "$file" ] && continue

  match_count=0
  line_number=0
  buffer=()

  while IFS= read -r line || [ -n "$line" ]; do
    ((line_number++))
    buffer+=("$line")

    match=false
    check_line="$line"

    # Whole word match
    if $WHOLE_WORD; then
      [[ $check_line =~ (^|[^[:alnum:]_])$PATTERN([^[:alnum:]_]|$) ]] && match=true
    elif $WHOLE_LINE; then
      [[ $check_line == "$PATTERN" ]] && match=true
    else
      [[ $check_line =~ $PATTERN ]] && match=true
    fi

    # Invert
    $INVERT && match=! $match

    if $match; then
      ((match_count++))
      ((total_matches++))

      # Context output
      start=$((line_number - BEFORE))
      [ $start -lt 1 ] && start=1
      end=$((line_number + AFTER))

      for ((i=start; i<=end && i<=${#buffer[@]}; i++)); do
        output="${buffer[i-1]}"

        if $COLOR; then
          output=$(sed -E "s/($PATTERN)/\x1b[31m\1\x1b[0m/gI" <<< "$output")
        fi

        if $NUMBER; then
          echo "${i}: $output"
        else
          echo "$output"
        fi
      done

      if [ $LIMIT_MATCHES -gt 0 ] && [ $match_count -ge $LIMIT_MATCHES ]; then
        break
      fi
    fi

  done < "$file"

  if $COUNT; then
    echo "$file:$match_count"
  fi

  if $LIST_MATCH && [ $match_count -gt 0 ]; then
    echo "$file"
  fi

  if $LIST_NO_MATCH && [ $match_count -eq 0 ]; then
    echo "$file"
  fi
done

if $COUNT && [ ${#FILES[@]} -gt 1 ]; then
  echo "Total: $total_matches"
fi
