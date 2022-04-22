


#requires -version 2

function invoke-removeprinter {
 <#
 .SYNOPSIS
Removes Microsofts XPS Printer and Microsofts print to PDF printer
 #>
    # Remove XPS Printer
    Remove-Printer -Name "Microsoft XPS Document Writer"

    # Remove PDF Printer
    Remove-Printer -Name "Microsoft Print to PDF"
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