#!/bin/bash

# My custom TODO solution!
export TODO_PATH=~/TODO
alias q="cat $TODO_PATH"
alias qe="v $TODO_PATH"
qa() {
    echo "[ ] $(date -I) SHA:$(echo -n $@ | shasum) $@" >> $TODO_PATH
}
qd() {
    if [[ $1 = "--dry-run" ]] || [[ $1 = "-n" ]]; then
        shift 1
        echo "Dry Run:"
        sed "s/\[ \].\+$@.\+/[X]\0/" $TODO_PATH | sed "s/\[X\]\[ \]/[X]/" | grep $@
        return 0
    fi
    if [[ ${#@} = 0 ]]; then
        echo "Error: empty input"
        return 2
    fi
    # This is a fucking hack. Revise later!
    sed -i "s/\[ \].\+$@.\+/[X]\0/" $TODO_PATH
    sed -i "s/\[X\]\[ \]/[X]/" $TODO_PATH
    cat $TODO_PATH | grep $@
}
qu() {
    if [[ $1 = "--dry-run" ]] || [[ $1 = "-n" ]]; then
        shift 1
        echo "Dry Run:"
        sed "s/\[ \].\+$@.\+/[X]\0/" $TODO_PATH | sed "s/\[X\]\[ \]/[X]/" | grep $@
        return 0
    fi
    if [[ ${#@} = 0 ]]; then
        echo "Error: empty input"
        return 2
    fi
    # This is a fucking hack. Revise later!
    sed -i "s/\[X\].\+$@.\+/[ ]\0/" $TODO_PATH
    sed -i "s/\[ \]\[X\]/[ ]/" $TODO_PATH
    cat $TODO_PATH | grep $@
}
