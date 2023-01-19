#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clone Safari URL in iTerm
# @raycast.mode silent
# @raycast.packageName Navigation
#
# Optional parameters:
# @raycast.icon images/iterm-logo.png
#
# Documentation:
# @raycast.author Luke Karrys

tell application "Safari"
	set safariUrl to URL of front document
  set githubUrl to my replace_chars(safariUrl, "https://github.com/", "")
  set urlParts to my the_split(githubUrl, "/")
  set org to item 1 of urlParts
  set repo to item 2 of urlParts
  set command to "clear; clone " & org & " " & repo
end tell

tell application "iTerm"
    activate
    set hasNoWindows to ((count of windows) is 0)
    if hasNoWindows then
        create window with default profile
    end if
    select first window

    tell the first window
        if hasNoWindows is false then
            create tab with default profile
        end if
        tell current session to write text command
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
