
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

-> set *DisableRegistryTools* to "1". If the Value doesn't exist, create a new 32-bit DWORD value *DisableRegistryTools* (Even on 64-bit systems)

CMD command:
```
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /t Reg_dword /v DisableRegistryTools /f /d 1
```

Powershell command:
```
Set-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableRegistryTools" -Force -Value 1`
```

**Via GPO:**

Enable the following option:
```
User Configuration\Administrative Templates\System\Prevent access to registry editing tools
```

## Restrict access to Control panel
Prohibit access to  Control Panel (control.exe) und PC Settings (SystemSettings.exe)

**Via Registry:**
`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer`

-> set "NoControlPanel" to "1". If the Value doesn't exist, create a new 32-bit DWORD value *NoControlPanel* (Even on 64-bit systems)

**Via GPO:**

Enable the following option:
```
User Configuration\Administrative Templates\Control Panel\Prohbit access to Control Panel and PC settings
```

## Restrict access to task manager

**Via GPO:**

Enable the following option:
```
User Configuration\Administrative Templates\System\Ctr+Alt+Del Options\Remove Task Manager
```

## Restrict access to mmc snap-ins

Settings for restricting access to Management Console snap-ins can be found at the following location:
```
User Configuration\Administrative Templates\Windows Components\Microsoft Management Console\Restricted/Permitted snap-ins\
```

| Policy | Setting | Description |
| ----------- | ----------- | ----------- |
| *Active Directory Domains and Trusts* | Disabled |  |
| *Active Directory Sites and Services* | Disabled |  |
| *Active Directory Users and Computers* | Disabled |  |
| *Certificates* | Disabled |  |
| *Computer Management* | Disabled |  |
| *Component Services* | Disabled |  |
| *Device Manager* | Disabled |  |
| *Event Viewer* | Disabled |  |
| *Services* | Disabled |  |
| *Shared Folders* | Disabled |  |
| ...[TBD]... | Disabled |  |


# Further hardening settings of Windows components

## GPO Settings for Start menu and task bar

Settings for restricting options in the start menu and task bar can be found at the following location:
```
User Configuration\Administrative Templates\Start Menu and Taskbar\
```

| Policy | Setting | Description |
| ----------- | ----------- | ----------- |
| *Disable context menus in the Start Menu* | Enabled | Disable Context menu (right click) |
| ...[TBD]... | | |




## GPO Settings for hardening the file explorer

Settings for restricting the Windows file explorer can be found at the following location:
```
User Configuration\Administrative Templates\File Explorer\
```

| Policy | Setting | Description |
| ----------- | ----------- | ----------- |
| *Prevent access to drives from My Computer* | Enabled | Prevent access to local drives in the file explorer |
| *Remove File menu from File Explorer* | | Remove File menu from File Explorer |
| ...[TBD]... | | |
