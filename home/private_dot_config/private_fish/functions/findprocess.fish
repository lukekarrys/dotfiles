function findprocess
  ps -x | grep "ttys" | grep $argv | grep -v "grep"
end