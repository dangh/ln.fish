function ln --description "Create symbolic links with relative paths"
  set --local flags
  set --local sources
  set --local target
  argparse --ignore-unknown 'F' 'f' 'h' 'i' 'n' 's' 'v' -- $argv
  set --query _flag_F && set --append flags -F
  set --query _flag_f && set --append flags -f
  set --query _flag_h && set --append flags -h
  set --query _flag_i && set --append flags -i
  set --query _flag_n && set --append flags -n
  set --query _flag_s && set --append flags -s
  set --query _flag_v && set --append flags -v
  if test (count $argv) -gt 1
    set target $argv[-1]
    set --erase argv[-1]
  else
    set target .
  end
  set --local target_dir $target
  test -d $target_dir || set target_dir (dirname $target_dir)
  for source in $argv
    set --append sources (relpath $target_dir $source)
  end
  command ln $flags $sources $target
end
