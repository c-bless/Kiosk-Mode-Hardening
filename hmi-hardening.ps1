#requires -version 2

<#
.SYNOPSIS
   This scripts executes a collection of commands to harden a windows based HMI. THis includes disabling of hotkeys, blocking of some applications, removing of file printers.
.DESCRIPTION
   This scripts executes a collection of commands to harden a windows based HMI. 
.NOTES
   Script: hmi-hardening.ps1
   Repo: https://bitbucket.org/cbless/Kiosk-Mode-Hardening
   Author: Christoph Bless
   License: GNU General Public License in version 3. See http://www.gnu.org/licenses/ for further details.
  
.EXAMPLE
  import-module hmi-hardening.ps1
  invoke-disablehotkeys
  invoke-removeprinters
  invoke-blockapps
#>


function invoke-removeprinter {
 <#
 .SYNOPSIS
Removes Microsofts XPS Printer and Microsofts print to PDF printer
 #>
   # Remove XPS Printer
   Remove-Printer -Name "Microsoft XPS Document Writer" -ErrorAction SilentlyContinue

   # Remove PDF Printer
   Remove-Printer -Name "Microsoft Print to PDF" -ErrorAction SilentlyContinue
 }


 
function invoke-disablehotkeys {
 <#
 .SYNOPSIS
 Disables shortcuts and hotkeys via registry settings.
 #>
   # Disbable Sticky Keys (5xShift)
   Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys\" -Name "Flags" -Value "506"

   # Disable Filter Keys 
   Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response\" -Name "Flags" -Value "122"

   # Disable Toggle Keys
   Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\ToggleKeys\" -Name "Flags" -Value "58"

   # Disable Windows Keys
   Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\" -Name "NoWinKeys" -Value 0x1
 }


function invoke-blocksystemapps {
 <#
 .SYNOPSIS
 Blocks some system apps like cmd or taskmgr
 #>
   $cmdpath = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\System\"

   IF(!(Test-Path $cmdpath))
   {

    New-Item -Path $cmdpath -Force | Out-Null
   }

   # Block CMD but allow batch files
   Set-ItemProperty -Path $cmdpath -Name "DisableCMD" -Force -Value 2

   # Block reg edit tools
   Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableRegistryTools" -Force -Value 1

   # Block access to control panel
   Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoControlPanel" -Force -Value 1`

   # Block access to taskmgr
   Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableTaskMgr" -Force -Value 1`

 }
 