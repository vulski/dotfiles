if [[ "$TERM" =~ "tmux".* ]]; then
        echo "";
else
        ruby ~/scripts/seeyou.rb; sleep 2
fi
