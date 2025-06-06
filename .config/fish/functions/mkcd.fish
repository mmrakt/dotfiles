# https://qiita.com/piruty/items/20780a17c8a9fd04ba41
function mkcd
  if test (count $argv) -eq 0
    echo "Pass dir name"
    return 1
  end

  set dirname $argv[1]
  mkdir -p $dirname
  eval "cd" $dirname
end