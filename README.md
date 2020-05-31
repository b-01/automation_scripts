# automation_scripts
Scripts and samples to automate stuff on Linux, Windows machines.

| Folder | Program | Lang | Description |
|-|-|-|-|
|  | [auto_nmap_scan](auto_nmap_scan/) | Bash | Run nmap against a set of IPs inside hosts.txt  |
| [mailcow-dockerized](mailcow-dockerized/) | clean_backups | Bash | Bash script to automatically backup mailcow-dockerized data using the provided helper script "backup_and_restore.sh". Keeps $MAX_BACKUPS on disk. |
| [mailcow-dockerized](mailcow-dockerized/) | pullstyle_backup | Bash | Bash script that sshs into a mailcow-dockerized, triggers a backup and then copies the backup data to the target location. |
|  | [mount_vbox_share](mount_vbox_share/) | Bash | Mount a virtualbox shared folder inside a VM |
|  | [update-cyberchef](update_cyberchef) | Powershell | Windows Powershell script to automatically download the latest release (tag) from gchq/CyberChef repository, unzip the files and rename them, so that everything works with my bookmarks. |
|  | [update-vscode](update_vscode/) | Python | Downloads the latest vscode tarball into memory and extracts it into the given directory. |
|  |  |  |  |  |
