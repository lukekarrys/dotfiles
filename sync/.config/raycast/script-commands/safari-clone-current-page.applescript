#!/usr/bin/osascript

# @raycast.title Clone Safari URL in iTerm
# @raycast.description Clone Safari URL in iTerm
# @raycast.author Luke Karrys

# @raycast.icon images/safari.png
# @raycast.mode silent
# @raycast.packageName Safari
# @raycast.schemaVersion 1

tell application "Safari"
	set safariUrl to URL of front document
  set githubUrl to my replace_chars(safariUrl, "https://github.com/", "")
  set urlParts to my the_split(githubUrl, "/")
  set org to item 1 of urlParts
  set repo to item 2 of urlParts
end tell

tell application "iTerm2"
  tell current window
    create tab with default profile
  end tell

  tell current tab of current window
    set _new_session to last item of sessions
  end tell

  tell _new_session
    select
    write text "clone " & org & " " & repo
  end tell
end tell

on the_split(theString, theDelimiter)
  -- save delimiters to restore old settings
  set oldDelimiters to AppleScript's text item delimiters
  -- set delimiters to delimiter to be used
  set AppleScript's text item delimiters to theDelimiter
  -- create the array
  set theArray to every text item of theString
  -- restore the old setting
  set AppleScript's text item delimiters to oldDelimiters
  -- return the result
  return theArray
end theSplit

on replace_chars(this_text, search_string, replacement_string)
  set AppleScript's text item delimiters to the search_string
  set the item_list to every text item of this_text
  set AppleScript's text item delimiters to the replacement_string
  set this_text to the item_list as string
  set AppleScript's text item delimiters to ""
  return this_text
end replace_chars