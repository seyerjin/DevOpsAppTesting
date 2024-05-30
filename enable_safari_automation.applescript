tell application "Safari" to activate
delay 5
tell application "System Events"
    tell process "Safari"
        click menu item "Preferences…" of menu "Safari" of menu bar 1
        delay 5
        click button "Advanced" of toolbar 1 of window "Preferences"
        delay 5
        set theCheckbox to checkbox "Show Develop menu in menu bar" of window "Preferences"
        if value of theCheckbox is 0 then
            click theCheckbox
        end if
        delay 5
        click menu item "Allow Remote Automation" of menu "Develop" of menu bar 1
        delay 5
        click button 1 of window "Preferences"
        delay 5
        keystroke "w" using command down
    end tell
end tell
