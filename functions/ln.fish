function ln -d "Create symbolic links with relative paths"
  set -l flags
  set -l sources
  set -l target
  argparse -i F f h i n s v -- $argv
  set -q _flag_F && set -a flags -F
  set -q _flag_f && set -a flags -f
  set -q _flag_h && set -a flags -h
  set -q _flag_i && set -a flags -i
  set -q _flag_n && set -a flags -n
  set -q _flag_s && set -a flags -s
  set -q _flag_v && set -a flags -v
  if test (count $argv) -gt 1
    set target $argv[-1]
    set -e argv[-1]
  else
    set target .
  end
  set -l target_dir $target
  test -d $target_dir || set target_dir (dirname $target_dir)
  for source in $argv
    if set -q _flag_s
      set -a sources (relpath $target_dir $source)
    else
      set -a sources $source
    end
  end
  command ln $flags $sources $target
end
