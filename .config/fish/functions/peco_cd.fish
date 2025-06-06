function _peco_cd
  if [ (count $argv) ]
    ghq list -p | peco --query "$LBUFFER" | read foo
  end
  if [ $foo ]
    builtin cd $foo
  else
    commandline ''
  end
end
function peco_cd
  begin
  end | sed -e 's/\/$//' | awk '!a[$0]++' | _peco_cd $argv
end
