for file in *; do
    ext="${file##*.}"
    mkdir -p "$ext"
    mv "$file" "$ext/"
done
#!/bin/bash