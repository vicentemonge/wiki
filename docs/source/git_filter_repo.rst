**COMO ADELGACE PE LINUX PACKAGE**
----------------------------------
# Install git-filter-repo
git clone git@github.com:newren/git-filter-repo.git (lo tengo en ~/.mio)
export PATH=$PATH:/path/to/git-filter-repo (lo tengo en ~/.bash_git)

# List files por tamaño de archivo
git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | sed -n 's/^blob //p' | sort --numeric-sort --key=2 | tail -n 100 | cut -c 1-12,41- | $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest


# Limpieza pe_linux_package
git filter-repo --path build/cm3-pe_2019-11-18_1.img --path build/cm3-pe_2019-11-18_1.img --path build/cm3-pe_2019-11-18_1.img --invert-path -f
git filter-repo --path packages/pe-cc-arm-debian-11-gnueabihf_package --invert-path -f
git filter-repo --path-glob '*.deb' --invert-path -f
git filter-repo --path-glob 'packages/pebase_package/*.tar.xz' --invert-path -f
git filter-repo --path-glob 'packages/pebase_package/*.ubi' --invert-path -f
git filter-repo --path-glob '*.ubi' --invert-path -f
git filter-repo --path packages/pesecurity_package.tar --invert-path -f
git filter-repo --path packages/penode_package/usr/bin/node --invert-path -f
git filter-repo --invert-path -f --path packages/pesecurity_package/etc/pe/boot/boot.img
git filter-repo --invert-path -f --path packages/peloki_package/usr/local/bin/loki/loki-linux-arm
git filter-repo --invert-path -f --path packages/penode_12.18.2-0_armhf/usr/bin/node
git filter-repo --invert-path -f --path sd/etc/pe/sfm/backend.tar.gz
git filter-repo --invert-path -f --path packages/penode_12.18.2-0_armhf/bin/node
git filter-repo --invert-path -f --path sd/home/admin/web_sfm/backend.tar.gz
git filter-repo --invert-path -f --path packages/pesfm_package/etc/pe/sfm/backend.tar.gz
git filter-repo --invert-path -f --path packages/pesfm_1.0-0_armhf/etc/pe/sfm/backend.tar.gz
git filter-repo --invert-path -f --path packages/pesecurity_package/etc/pe/boot/initramfs.gz
git filter-repo --invert-path -f --path sd/etc/pe/sfm/backend.tar.xz
git filter-repo --invert-path -f --path packages/peautotest-aio-charger-cm4_package/
git filter-repo --invert-path -f --path packages/pesfm_package/etc/pe/sfm/
git filter-repo --invert-path -f --path packages/peocpp-server_package/etc/pe/ocpp/node_modules_11.tar.xz
git filter-repo --invert-path -f --path-glob '*.img'
git filter-repo --invert-path -f --path-glob 'packages/peinvoice_package/usr/local/*.armv7l'
git filter-repo --invert-path -f --path packages/pebilling_package
git filter-repo --invert-path -f --path-glob 'packages/pehmi-security_package/etc/pe/hmi/ssl_*.gz'
git filter-repo --invert-path -f --path-glob 'packages/pehmi-security_package/etc/pe/hmi/sshd.apk'
git filter-repo --invert-path -f --path sd/etc/pe/modbus/nube_linux_modbus_config.tar.gz
git filter-repo --invert-path -f --path packages/pepod-charger-manager_package/usr/local/bin/pepod-charger-manager/pepod-charger-manager
git filter-repo --invert-path -f --path packages/pebase_1.0-0_all/etc/pe/modbus/nube_linux_modbus_config.tar.gz



# Cleaning local??
git reflog expire --expire=now --all && git gc --prune=now --aggressive


# TO MAKE A REPO BACKUP
https://stackoverflow.com/questions/6865302/push-local-git-repo-to-new-remote-including-all-branches-and-tags

To push all your branches, use either (replace REMOTE with the name of the remote, for example "origin"):

git push REMOTE '*:*'
git push REMOTE --all

To push all your tags:

git push REMOTE --tags

Finally, I think you can do this all in one command with:

git push REMOTE --mirror

However, in addition --mirror, will also push your remotes, so this might not be exactly what you want.

