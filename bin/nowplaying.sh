#! /bin/bash
arch -i386 osascript -e 'tell application "System Events" to if ((name of processes) contains "iTunes") then do shell script ("osascript -e " & quoted form of ("tell application \"iTunes\" to if player state is playing then \"Now Playing: \" & name of current track & \" - \" & artist of current track" & ""))'
