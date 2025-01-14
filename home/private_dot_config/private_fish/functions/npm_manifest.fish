function npm_manifest
  set package_name $argv[1]
  curl -s https://registry.npmjs.org/$package_name
end