if [[ -f ~/.bashrc ]]; then
  source ~/.bashrc
fi

eval $(keychain --eval --agents ssh --quiet --timeout 60 --nogui --noask)
