function p() {
    if [ -z "$1" ]; then
        cd ~/projects
    else
        cd ~/projects
        if [ -d "$1" ]; then
            cd $1
        else
            exact=$(find . -maxdepth 2 -type d | grep "/$1$" | head -n1)
            if [ -d "$exact" ]; then
                cd $exact
            else
                cd $(find . -maxdepth 2 -type d | grep "$1" | head -n1)
            fi
        fi
    fi
}

function clone() {
    p
    mkd $1
    if [ -d "$2" ]; then
        cd $2
        git pull
    else
        gh repo clone $1/$2
        cd $2
    fi
}

function trep() {
    if [ -z "$1" ]; then
        tree -aCd -L 2 ~/projects
    else
        tree -aCd -L 1 ~/projects/$1
    fi
}

compctl -k "($(tree -idn -L 2 ~/projects/ | head -n -2 | tail -n +2 | tr "\n" " "))" p trep clone

