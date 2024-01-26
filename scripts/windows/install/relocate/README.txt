# Use these commands in an administrator cmd after inserting the XML onto your partition.

net stop wmpnetworksvc
%windir%\system32\sysprep\sysprep.exe /oobe /reboot /unattend:d:\relocate.xml