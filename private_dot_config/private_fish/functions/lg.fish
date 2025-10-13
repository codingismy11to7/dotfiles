function lg --wraps=lazygit --description 'alias lg lazygit'
  set -l cwd_file ~/.config/lazygit/cwd

  env LAZYGIT_NEW_DIR_FILE=$cwd_file lazygit $argv

  if test -f $cwd_file
    set --local target_dir (cat $cwd_file)

    if test -d $target_dir
      cd $target_dir
    end

    rm -f $cwd_file
  end

end
