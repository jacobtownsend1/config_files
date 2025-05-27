#!/usr/bin/env bash

# pattern_create.sh — Non-repeating pattern generator like Metasploit's Rex::Text.pattern_create

show_help() {
  echo "Usage: $0 -l <length>"
  echo "Example: $0 -l 100"
  exit 1
}

# Defaults
SET1=( {A..Z} )
SET2=( {a..z} )
SET3=( {0..9} )

# Parse args
while getopts ":l:h" opt; do
  case $opt in
    l) LENGTH="$OPTARG" ;;
    h) show_help ;;
    \?) echo "[x] Invalid option: -$OPTARG" >&2; show_help ;;
    :) echo "[x] Option -$OPTARG requires an argument." >&2; show_help ;;
  esac
done

[[ -z "$LENGTH" ]] && { echo "[x] Missing -l <length>"; show_help; }

# Generate the unique cyclic pattern
PATTERN=""
for a in "${SET1[@]}"; do
  for b in "${SET2[@]}"; do
    for c in "${SET3[@]}"; do
      CHUNK="${a}${b}${c}"
      PATTERN+="$CHUNK"
      [[ ${#PATTERN} -ge $LENGTH ]] && {
        echo "${PATTERN:0:$LENGTH}"
        exit 0
      }
    done
  done
done

exit 1

