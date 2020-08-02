set cleaner_name to getParam("Cleaner")

tell application "textsoap8Agent"
	try
		if cleaner_name is in (groupItems from "Library") then
			cleanClipboard with cleaner_name
		else
			activate
			display alert "Cleaner Ò" & cleaner_name & "Ó does not exist"
			return
		end if
	on error e_message
		activate
		display alert e_message
		return
	end try
end tell

on getParam(param_name)
	return do shell script "echo \"$KMPARAM_" & param_name & "\""
end getParam