# strings
[ -z "$s" ]   # true if empty
[ -n "$s" ]   # true if not empty
[ "$a" = "$b" ]  # string equal
[[ $s =~ ^[A-Z]+$ ]]  # regex match (Bash [[ ])

# numbers
[ "$a" -eq "$b" ]
(( a > b ))

# files
[ -e file ]  # exists
[ -f file ]  # regular file
[ -d dir ]   # directory
[ -s file ]  # exists and not empty
[ -x file ]  # executable

# terminal check
[ -t 1 ] && echo "stdout is a terminal"

# combine
if [[ -f "$f" && -r "$f" ]]; then
  echo "readable file"
fi

# check if a variable is empty
s=""

if [[ -z "$s" ]] ;then echo "empty string"; else echo "not empty"; fi

# check if a file is a directory or a readable file
file="etc/hosts"

if[[ -d "$file"]];then echo "is a directory";
elif [[ -f "$file" && -r "$file" ]];then echo "is a file and its a readable file";
else echo "not a file or directory"; fi

# regex
read -p "enter digits: " v
if [[ $v =~ ^[0-9]+$ ]]; then echo "digits"; else echo "not digits"; fi
