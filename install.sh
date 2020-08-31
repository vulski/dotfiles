#!/bin/sh
#stolen from the best

set -e

BASE="$(cd "$(dirname "$0")" && pwd)"

# Very simple install script
for file in `find ${BASE} -maxdepth 1 -not -name '.*' -not -name install.sh -not -name bin -not -name tasks -not -name etc -not -name README.md -not -name LICENSE -type f`; do
    filename=`basename "$file"`
    echo "ln -sf $BASE/$filename -> ~/.$filename"
    ln -sf "$BASE/$filename" ~/.$filename
done

dirs=('$HOME/.config/nvim' '$HOME/scripts' '$HOME/.config/awesome' '$HOME/.config/i3' '$HOME/.ctag.d' '$HOME/bin' '$HOME/.vim' '$HOME/.weechat' '$HOME/wikis/general') 
for dir in ${dirs[@]}; do
    rm -rf ${dir}
    echo rm -rf ${dir}
    parsed="$(echo $dir | sed 's/$HOME\///g' | sed 's/\.//')"
    echo "ln -sfn $(PWD)/$parsed ${dir}" 
    ln -sfn $(PWD)/$parsed ${dir}
done
exit



touch ~/.secrets
touch ~/.vimrc_specific
echo "Puts secrets in ~/.secrets"
echo "Put .vimrc machine specific settings in .vimrc_specific"
