tell application "Safari" to activate
delay 5
tell application "System Events"
    tell process "Safari"
        -- Open Preferences
        click menu item "Preferences…" of menu "Safari" of menu bar 1
        delay 5

        -- Click Advanced tab
        click button "Advanced" of toolbar 1 of window "Preferences"
        delay 5

        -- Check if Develop menu is shown
        set developCheckbox to checkbox "Show Develop menu in menu bar" of window "Preferences"
        if not (get value of developCheckbox) then
            click developCheckbox
        end if
        delay 5

        -- Open Develop menu and enable Remote Automation
        set frontmost to true
        tell application "System Events"
            keystroke "d" using {command down, option down}
            delay 5
            click menu item "Allow Remote Automation" of menu "Develop" of menu bar 1
        end tell
        delay 5

        -- Close Preferences window
        keystroke "w" using command down
    end tell
end tell
