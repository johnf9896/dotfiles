#!/usr/bin/env bash

set -e

usage() {
    LESS=-FEXR less <<HELP
interactive.bash [OPTIONS]
Install and configure almost everything after a fresh install

-a    do everything
-b    install binary scripts
-h    show this help
HELP
}

declare -A colors
colors[red]=$(tput setaf 1)
colors[green]=$(tput setaf 2)
colors[blue]=$(tput setaf 4)
colors[reset]=$(tput sgr0)

declare distro
declare everything
declare custom
declare binaries

color() {
    local c
    c="$1"
    shift
    printf '%s' "${colors[$c]}"
    printf '%s\n' "$@"
    printf '%s' "${colors[reset]}"
}

err() {
    color red "$@" >&2
}

die() {
    [[ -n "$1" ]] && err "$1"
    exit 1
}

should_do() {
    [[ -n "$1" || -n "$everything" ]] && return 0
    [[ -n "$custom" ]] && return 1

    while true; do
        read -rp "$2 (Y/n) " answer
        case $answer in
        Y | y | yes | "") return 0 ;;
        N | n | no) return 1 ;;
        *) err "Invalid answer" ;;
        esac
    done
}

verify_distro() {
    if [[ -r /etc/os-release ]]; then
        distro=$(awk -F'=' '"NAME" == $1 { gsub("\"", "", $2); print tolower($2); }' /etc/os-release)
        distro="${distro%% *}"
    fi

    case "$distro" in
    manjaro | ubuntu | arch)
        color green "Found distro: $distro"
        return 0
        ;;
    *) die "Unknown distro '$distro' :(" ;;
    esac
}

while getopts 'abh' opt; do
    case "$opt" in
    a) everything=1 ;;
    b)
        binaries=1
        custom=1
        ;;
    h)
        usage
        exit 0
        ;;
    *)
        usage
        exit 1
        ;;
    esac
done

shift "$((OPTIND - 1))"

install_binary_scripts() {
    echo "==================================="
    echo "Installing binaries scripts"
    echo "==================================="

    bin=~/.local/bin
    mkdir -p $bin
    cd ~/dotfiles

    while IFS= read -r -d '' script; do
        basename "$script"
        ln -fs -- "$PWD/$script" "$bin"
    done < <(find bin -type f -perm -+x -print0)
}

main() {
    verify_distro

    (should_do "$binaries" "Install binary scripts?") && install_binary_scripts

    return 0
}

main
