tell application "Safari" to activate
delay 2
tell application "System Events"
    tell process "Safari"
        click menu item "Preferences…" of menu "Safari" of menu bar 1
        delay 1
        click button "Advanced" of toolbar 1 of window "Preferences"
        delay 1
        click checkbox "Show Develop menu in menu bar" of window "Preferences"
        delay 1
        click menu item "Allow Remote Automation" of menu "Develop" of menu bar 1
        delay 1
        click button 1 of window "Preferences"
        delay 1
        keystroke "w" using command down
    end tell
end tell
