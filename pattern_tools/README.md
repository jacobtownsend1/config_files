# Pattern Tools

Cyclical pattern creation tools to replace metasploit framework's implementation...
I really liked using theirs', but it felt a little ridiculous to install msf just
for these little scripts. I also don't really need the extra set specification
functions or error handling.

## patterncreate.sh
Creates a cyclical text pattern:
```
Usage: /software/pattern_tools/patterncreate.sh -l <length>
Example: /software/pattern_tools/patterncreate.sh -l 100

$ patterncreate -l 25
Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7A
```

## patternoffset.sh
Finds the offset of a given substring in the cyclical patter:
```
Usage: /software/pattern_tools/patternoffset.sh -q <pattern> [-l <max_length>]
Example: /software/pattern_tools/patternoffset.sh -q Aa3

$ patternoffset -q Ad2A
[✓] Offset: 96
```

