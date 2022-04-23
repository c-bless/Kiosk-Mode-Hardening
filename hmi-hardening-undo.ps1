#requires -version 2

<#
.SYNOPSIS
   THis script can be used to undo some of the settings done with the hardening script.
.DESCRIPTION
   THis script can be used to undo some of the settings done with the hardening script.
.NOTES
   Script: hmi-hardening.ps1
   Repo: https://bitbucket.org/cbless/Kiosk-Mode-Hardening
   Author: Christoph Bless
   License: GNU General Public License in version 3. See http://www.gnu.org/licenses/ for further details.
  
.EXAMPLE
  import-module hmi-hardening.ps1
  invoke-enablehotkeys
#>
 
function invoke-enablehotkeys {
 <#
 .SYNOPSIS
 Disables shortcuts and hotkeys via registry settings.
 #>
   # Reenable Sticky Keys (5xShift)
   Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys\" -Name "Flags" -Value "510"

   # Reenable Filter Keys 
   Remove-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response\" -Name "Flags"

   # Reenable Toggle Keys
   Remove-ItemProperty -Path "HKCU:\Control Panel\Accessibility\ToggleKeys\" -Name "Flags"

   # Reenable Mouse Keys
   Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\MouseKeys\" -Name "Flags" -Value "63"

   # Reenable Windows Keys
   Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\" -Name "NoWinKeys"
 }