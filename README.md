# README #

This Project has been created to collect several hardening settings for HMIs. Those settings including various ways how to configure them can be found under the following link:

* [General Hardening Settings for Windows HMIs](https://github.com/c-bless/Kiosk-Mode-Hardening/wiki)

Some of those settings have been prepared as PowerShell script that can be used to configure them locally on an HMI. The script is licensed under the GNU General Public License in version 3. See http://www.gnu.org/licenses/ for further details.

*BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE,
THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT
PERMITTED BY APPLICABLE LAW. EXCEPT WHEN OTHERWISE
STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER
PARTIES PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF
ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO
THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.
SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE
COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.*

# Examples

Import the PowerShell module

```
import-module hmi-hardening.ps1
```

Afterwards the following commands are available

`invoke-disablehotkeys` to disable hotkeys and shortcuts
`invoke-removeprinter` to remove file printers (XPS / PDF)
`invoke-blocksystemapps` to block system apps (e.g. CMD, Regedit, TaskManager)
