function node_repl
  set version $argv[1]
  fnm install "$version" --log-level=quiet
  if test $status -eq 0
    fnm exec --using="$version" node
  end
end