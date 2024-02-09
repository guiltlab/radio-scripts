# !/bin/bash
# this script recursively looks for all FLAC files in the current directory, finds those who have the same title
# and prints all of them to a format usable for foobar2000 query
# -i = Ignore differences in case when comparing lines
# -d Print only duplicate lines.
# -c Print the number of times each line occurred along with the line.
# --check-chars=N Compare N characters on each line (optional)

# one liner: 
# find . -name "*.flac" -exec metaflac --show-tag=title {} \; | sort | uniq --ignore-case -d -c | sed 's/.*title=//I' | sed '1s/^/%title% HAS /; 2,$s/^/OR %title% HAS /' | paste -sd ' ' > ../reports/dupes-title.txt

find . -name "*.flac" -exec metaflac --show-tag=title {} \; \
  | sort \
  | uniq --ignore-case -d -c \
  | sed 's/.*title=//I' \
  | sed '1s/^/%title% HAS /; 2,$s/^/OR %title% HAS /' \
  | paste -sd ' ' \
  > ../reports/dupes-title.txt
