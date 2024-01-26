@echo off
setlocal

REM Specify the NFS server IP address and shared folder path for each drive
set "NFS_SERVER_1=192.168.100.13"
set "NFS_SHARE_PATH_1=home\lyes"
set "NFS_SHARE_PATH_2=media\ST500"

set "NFS_SERVER_2=192.168.100.11"
set "NFS_SHARE_PATH_3=home\lyes"

REM Function to mount the NFS share
:MountNFS
echo Mounting NFS share Z:...
mount -o anon "\\%NFS_SERVER_1%\%NFS_SHARE_PATH_1%" Z:
mount -o anon "\\%NFS_SERVER_1%\%NFS_SHARE_PATH_2%" Y:
timeout /t 2 /nobreak >nul
if errorlevel 1 (
    echo Failed to mount NFS share Z:.
    echo Unmounting Z:...
    umount Z:
    timeout /t 2 /nobreak >nul
) else (
    echo NFS share Z: mounted successfully.
)

REM Mount the second NFS share (if needed)
echo Mounting NFS share Y:...
mount -o anon "\\%NFS_SERVER_2%\%NFS_SHARE_PATH_3%" W:
timeout /t 2 /nobreak >nul
if errorlevel 1 (
    echo Failed to mount NFS share Y:.
    echo Unmounting Y:...
    umount Y:
    timeout /t 2 /nobreak >nul
) else (
    echo NFS share Y: mounted successfully.
)

REM End of the script
echo Script completed.