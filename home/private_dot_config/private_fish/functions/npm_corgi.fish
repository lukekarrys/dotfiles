function npm_corgi
  set package_name $argv[1]
  curl -s --header "Accept: application/vnd.npm.install-v1+json" https://registry.npmjs.org/$package_name
end