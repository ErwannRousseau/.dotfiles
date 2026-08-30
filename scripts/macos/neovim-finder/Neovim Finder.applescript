on open fileItems
	if class of fileItems is not list then set fileItems to {fileItems}
	set nodeExecutable to do shell script "/bin/zsh -lc 'export NVM_DIR=\"$HOME/.nvm\"; if [ -s \"$NVM_DIR/nvm.sh\" ]; then . \"$NVM_DIR/nvm.sh\"; fi; command -v node'"
	set nvimExecutable to do shell script "/bin/zsh -lc 'command -v nvim'"
	set shellPath to do shell script "/bin/zsh -lc 'printf %s \"$PATH\"'"
	set nodeDirectory to do shell script "/usr/bin/dirname " & quoted form of nodeExecutable
	set workingDirectory to do shell script "/usr/bin/dirname " & quoted form of POSIX path of item 1 of fileItems
	set commandLine to quoted form of nvimExecutable & " --"
	repeat with fileItem in fileItems
		set commandLine to commandLine & " " & quoted form of POSIX path of fileItem
	end repeat
	tell application id "com.mitchellh.ghostty"
		activate
		set terminalConfig to {initial working directory:workingDirectory, initial input:commandLine & "; exit" & linefeed, environment variables:{"PATH=" & nodeDirectory & ":" & shellPath}}
		new tab with configuration terminalConfig
	end tell
end open

on run
	return
end run
