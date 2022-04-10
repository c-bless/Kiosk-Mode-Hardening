
# User privileges
- Use a low privileged account for autologon to the operating system.
- If the application requires higher privileges create a dedicated account with administrative privileges and run the service / application in context of this account. But don't use this account for autologon to the system. It would be recommented to restict logon privileges of this account (e.g. deny interactive logon)  

# Auto logon
- Ensure that passwords are not visible in clear text in the windows registry (`[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\`)
- Insteat of the autologon via clear text password the tool autologon.exe from Sysinternals suite should be used


# Prevent KIOSK mode breakouts via hotkeys
This section contains some settings that try to prevent KIOSK mode escapes by using windows hotkeys or print functions in the application.

## Disable Sticky Keys
**Via GUI:**

`Settings > Ease of Access > Keyboard`

-> deselect "Allow the short cut key to start Sticky Keys"

**Via Registry:**

Disable Sticky Keys for the current user (by default the value is 510)
```
[HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys] Flags”=”506”
```

Disable Sticky Keys for the all users:
```
[HKEY_USERS\.DEFAULT\Control Panel\Accessibility\StickyKeys] “Flags”=”506”
```

And if it still not work, we can try to use 26 instead of 506 to see if they can help.


## Disable Filter Keys
**Via GUI:**

`Settings > Ease of Access > Keyboard`

-> deselect "Allow the short cut key to start Filter Keys"

**Via Registry:**

Disable Filter Keys for the current user
```
[HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response] “Flags”=”122”
```

Disable Filter Keys for all Users

`[HKEY_USERS\.DEFAULT\Control Panel\Accessibility\Keyboard Response] “Flags”=”122”`

## Disable Toggle Keys
**Via GUI:**

`Settings > Ease of Access > Keyboard`

-> deselect "Allow the short cut key to start Toggle Keys"

**Via Registry:**
Disable Toggle Keys for the current user
```
[HKEY_CURRENT_USER\Control Panel\Accessibility\ToggleKeys] “Flags”=”58”
```

Disable Toggle Keys for all users
```
[HKEY_USERS\.DEFAULT\Control Panel\Accessibility\ToggleKeys] “Flags”=”58”
```

## Remove XPS Printer

**Via GUI:**

“Turn Windows feature on or off”
In the Windows Features window, untick “Microsoft XPS Document Writer” then click “OK”.

**Via CMD:**
```
printui.exe /dl /n "Microsoft XPS Document Writer"
```

**Via Powershell:**
```
Remove-Printer -Name "Microsoft XPS Document Writer"
```

## Remove Print to PDF
**Via GUI:**
* Type “Turn Windows features” into the search bar and run “Turn Windows features on or off” result.
* In the list, just uncheck the box of “Microsoft Print to PDF”
* Hit OK and you’re done


**Via CMD:**
```
printui.exe /dl /n "Microsoft Print to PDF"
```

**Via Powershell:**
```
Remove-Printer -Name "Microsoft Print to PDF"
```


# Restrict Access to tools
This section contains some settings that try to restrict usable functions after a successful escape form the kiosk mode or when it is possible to open a file open/save dialog.

## Restrict Access to CMD

**Via GPO:**
```
User Configuration\Administrative Templates\System\Prevent access to the command prompt
```
-> set to "Enabled"

Here, you can also disable the command prompt script processing (.cmd and .bat).


**Using the Windows registry:**

Run regedit to open the Registry Editor. navigate to the following registry key:

`HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\System`

- If the Windows or System key is not present, you may be required to create them.

- In the right pane, double click DisableCMD and set its value to 0. ( if it is not present you can create one)


## Restrict access to registry editing tools
Regedit.exe and Reg.exe are blocked (reg query ...)


**Via Registry:**
`HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`

-> set "DisableRegistryTools" to "1". If the Value doesn't exist, create a new 32-bit DWORD value *DisableRegistryTools* (Even on 64-bit systems)


**Via GPO:**
```
User Configuration\Administrative Templates\System\Prevent access to registry editing tools
```
-> Enable it


## Restrict access to Control panel
Prohibit access to  Control Panel (control.exe) und PC Settings (SystemSettings.exe)

**Via Registry:**
`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer`

-> set "NoControlPanel" to "1". If the Value doesn't exist, create a new 32-bit DWORD value *NoControlPanel* (Even on 64-bit systems)

**Via GPO:**
```
User Configuration\Administrative Templates\Control Panel\Prohbit access to Control Panel and PC settings
```
-> set to "Enabled"

## Restrict access to task manager

## REstrict access to mmc snap-ins

# Further Hardening Settings

## Start menu and task bar
**Disable Context menu (right click)**
```
User Configuration\Administrative Templates\Start Menu and Taskbar\Disable context menus in the Start Menu
```
-> set to "Enabled"

....


## File explorer
**Access to local drives**
```
User Configuration\Administrative Templates\File Explorer\Prevent access to drives from My Computer
```
-> set to "Enabled"

....

**Remove File menu from File Explorer**
```
User Configuration\Administrative Templates\File Explorer\Remove File menu from File Explorer
```
-> set to "Enabled"




...
