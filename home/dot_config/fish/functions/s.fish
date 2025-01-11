function s
  if test (count $argv) -eq 0
    code -r .
  else
    code -r $argv
  end
end