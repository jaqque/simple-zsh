# zshrc
# read by interactive shells

simple_zsh=${simple_zsh:-$HOME/.simple_zsh}

sz_host=${${HOST%%.*}:-unknown}
sz_domain=${${HOST#*.}:-unknown}

typeset -a sz_zshrc_dirs
sz_zshrc_dirs=(
  $simple_zsh/zshrc.d
  $simple_zsh/zshrc.d/by-platform/$OSTYPE
  $simple_zsh/zshrc.d/by-domain/$sz_domain
  $simple_zsh/zshrc.d/by-host/$sz_host
  $simple_zsh/zshrc.d/by-uid/$UID
)
for i in {$#sz_zshrc_dirs..1}; do
  [[ ! -d $sz_zshrc_dirs[i] ]] && sz_zshrc_dirs[i]=() # remove element
done

for dir in $sz_zshrc_dirs; do
  for file in $dir/*(.); do
    [[ ! -r $file ]] && continue
	source $file
  done
done

