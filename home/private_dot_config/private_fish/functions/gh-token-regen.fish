function gh-token-regen -d "Regenerate an existing GitHub token"
  set -l token_id (command op item get $argv --format=json | jq -r '.fields[] | select(.label=="ID").value')
  if test $status -eq 0
    command open "https://github.com/settings/tokens/$token_id/regenerate"
    read -P "Enter new token: " new_token
    if test -n "$new_token"
      command op item edit $argv password="$new_token" > /dev/null
      echo "Token updated"
    else
      echo "No token entered"
      return 1
    end
    
  else
    echo "Failed to get token ID"
    return 1
  end
end

complete -c gh-token-regen -f
complete -c gh-token-regen -f -a '(
  op item list --tags=token --format=json | jq -r \'.[] | select(.tags[] | contains("github")) | "\\(.id)\\t\\(.title)"\'
)'