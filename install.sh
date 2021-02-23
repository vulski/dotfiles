#!/bin/sh
echo -e "--Make sure you are running this from the repo path--\n\n"
read -p "This will override your config files [Y/n]" -n 1 -r
echo    # move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]
then
    BASE="$(cd "$(dirname "$0")" && pwd)"
    # All dotfiles
    for file in `find ${BASE} -maxdepth 1 -not -name '.*' -not -name install.sh -not -name bin -not -name tasks -not -name etc -not -name README.md -not -name LICENSE -type f`; do
      filename=`basename "$file"`
      echo "ln -sf $BASE/$filename -> ~/.$filename"
      ln -sf "$BASE/$filename" ~/.$filename
    done

    # Neovim
    rm -rf ~/.config/nvim
    ln -s ${PWD}/config/nvim ~/.config/nvim

    # Scripts
    rm -rf ~/scripts
    ln -s ${PWD}/scripts ~/scripts

    # i3
    rm -rf ~/.config/i3
    ln -s ${PWD}/config/i3 ~/.config/i3

    # vim
    rm -rf ~/.vim
    ln -s ${PWD}/vim ~/.vim

    touch ~/.secrets
    touch ~/.vimrc_specific
    echo "Puts secrets in ~/.secrets"
    echo "Put .vimrc machine specific settings in .vimrc_specific"
fi
