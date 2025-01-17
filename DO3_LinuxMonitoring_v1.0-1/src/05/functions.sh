#!/bin/bash

check_parameters() {
    if [ "$#" -ne 1 ]; then
        echo "Использование: $0 <путь_к_директории/>"
        exit 1
    fi

    DIRECTORY="$1"
    if [[ "$DIRECTORY" != */ ]]; then
        echo "Ошибка: Путь должен заканчиваться на '/'"
        exit 1
    fi

    if [ ! -d "$DIRECTORY" ]; then
        echo "Ошибка: Директория '$DIRECTORY' не существует."
        exit 1
    fi
}


count_directories() {
    local dir="$1"
    find "$dir" -type d | wc -l
}


count_files() {
    local dir="$1"
    find "$dir" -type f | wc -l
}

# type files
count_config_files() {
    local dir="$1"
    find "$dir" -type f -name "*.conf" | wc -l
}

count_text_files() {
    local dir="$1"
    find "$dir" -type f ! -name "*.conf" ! -name "*.log" \
        ! -name "*.zip" ! -name "*.tar" ! -name "*.gz" \
        ! -name "*.bz2" ! -name "*.tgz" ! -name "*.tar.gz" \
        ! -name "*.tar.bz2" ! -executable | while read -r file ; do
        if file "$file" | grep -q 'text' ; then
            echo "$file"
        fi
    done | wc -l
}

count_executable_files() {
    local dir="$1"
    find "$dir" -type f -executable | wc -l
}

count_log_files() {
    local dir="$1"
    find "$dir" -type f -name "*.log" | wc -l
}

count_archive_files() {
    local dir="$1"
    find "$dir" -type f \( -name "*.zip" -o -name "*.tar" -o -name "*.gz" -o -name "*.bz2" -o -name "*.tgz" -o -name "*.tar.gz" -o -name "*.tar.bz2" \) | wc -l
}

count_symbolic_links() {
    local dir="$1"
    find "$dir" -type l | wc -l
}

top_five_directories() {
    local dir="$1"
    du -h --max-depth=1 "$dir" 2>/dev/null | sort -hr | head -n 5 | awk '{ print NR " - " $2 "/, " $1 }'
}

top_ten_files() {
    local dir="$1"
    find "$dir" -type f -exec du -h {} + 2>/dev/null | sort -hr | head -n 10 | awk '{ print NR " - " $2 ", " $1 ", " gensub(/.*\./,"","g",$2) }'
}

top_ten_executable_files() {
    local dir="$1"
    find "$dir" -type f -exec du -b {} + 2>/dev/null | sort -n -r | while read size filepath; do
        if file "$filepath" | grep -qE 'executable|script'; then
            md5hash=$(md5sum "$filepath" | awk '{ print $1 }')
            human_size=$(numfmt --to=iec-i --suffix=B "$size")
            echo "$filepath, $human_size, $md5hash"
        fi
    done | head -n 10 | awk '{ print NR " - " $1 ", " $2 ", " $3 }'
}

measure_execution_time() {
    local start_time=$(date +%s)
     "$@"
    local end_time=$(date +%s)
    local execution_time=$((end_time - start_time))
    echo "Script execution time (in seconds) = $execution_time"
}

display_result() {
    local dir="$1"
    local dir_count="$2"
    local file_count="$3"

    local config_count=$(count_config_files "$dir")
    local text_count=$(count_text_files "$dir")
    local exec_count=$(count_executable_files "$dir")
    local log_count=$(count_log_files "$dir")
    local archive_count=$(count_archive_files "$dir")
    local symlink_count=$(count_symbolic_links "$dir")

    echo "Total number of folders (including all nested ones) = $dir_count"
    echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
    top_five_directories "$dir"
    echo "Total number of files = $file_count"
    echo "Number of:"
    echo "Configuration files (with the .conf extension) = $config_count"
    echo "Text files = $text_count"
    echo "Executable files = $exec_count"
    echo "Log files (with the extension .log) = $log_count"
    echo "Archive files = $archive_count"
    echo "Symbolic links = $symlink_count"
    echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
    top_ten_files "$dir"
    echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
    top_ten_executable_files "$dir"
}