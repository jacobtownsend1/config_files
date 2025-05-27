#!/usr/bin/env bash

# pattern_offset.sh — Find the offset of a substring in a cyclic pattern

show_help() {
  echo "Usage: $0 -q <pattern> [-l <max_length>]"
  echo "Example: $0 -q Aa3"
  exit 1
}

# Defaults
SET1=( {A..Z} )
SET2=( {a..z} )
SET3=( {0..9} )
MAXLEN=8192

# Parse args
while getopts ":q:l:s:h" opt; do
  case $opt in
    q) QUERY="$OPTARG" ;;
    l) MAXLEN="$OPTARG" ;;
    h) show_help ;;
    \?) echo "[x] Invalid option: -$OPTARG" >&2; show_help ;;
    :) echo "[x] Option -$OPTARG requires an argument." >&2; show_help ;;
  esac
done

[[ -z "$QUERY" ]] && { echo "[x] Missing -q <pattern>"; show_help; }

# Generate pattern up to MAXLEN
PATTERN=""
for a in "${SET1[@]}"; do
  for b in "${SET2[@]}"; do
    for c in "${SET3[@]}"; do
      CHUNK="${a}${b}${c}"
      PATTERN+="$CHUNK"
      [[ ${#PATTERN} -ge $MAXLEN ]] && break 3
    done
  done
done

# Search for query
OFFSET=$(echo "$PATTERN" | grep -b -o "$QUERY" | cut -d: -f1)

if [[ -n "$OFFSET" ]]; then
  echo "[✓] Offset: $OFFSET"
else
  echo "[x] Pattern '$QUERY' not found within first $MAXLEN characters."
fi

