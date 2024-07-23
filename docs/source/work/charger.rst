CHARGER
=====================

ConfigVars
---------------------

Están en la base de datos /etc/pe/config.db


OCPP
-----------------
web cargador: https://192.168.204.10/

- Para setear los precios:
	ConfigVars -> 6. Show prices on HMI and enable POS

[PowerComms]
~~~~~~~~~~~~~~~~~~~~~~~~

G1 900 clave desarrollador
OCPP en Rpi:
	G5.1.1 Habilitador NO
	G8.23 preparing connected OFF
Al reiniciar placa hay que remover la protección
	SG2.3.14 SI

SG1.1.6 Reset sistema 1903

BUPS UPDATES
-------------

El proceso es **pe-lauchhupdate.sh**

La actualización en curso está en **/var/updates/.upgrade-tmp/**
La última está en **/var/updates/files/**

Para actualizar a mano hay que hacer:

.. code-block:: bash

	/usr/local/bin/pe-verify-bups.sh /var/updates/files/4.1.0_5_Signed_new_invoice1.0.3_sftp.bups /etc/pe/backend/lib/security/power_official_pub.pem
 	nohup /usr/local/bin/pe-launchupdate.sh &


PowerComms en Linux
------------------------
<!--
Yo tuve que hacer esto también
sudo apt install cabextract
-->

- Install Wine 8.x following https://wiki.winehq.org/Debian:

87138  sudo mkdir -pm755 /etc/apt/keyrings
87139  sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
87140  sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bullseye/winehq-bullseye.sources
87141  sudo apt update
87142  sudo apt install --install-recommends winehq-stable

- Install https://wiki.winehq.org/Winetricks:

87110  wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
87111  chmod +x winetricks 
87112  sudo mv winetricks /usr/local/bin/
87115  wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks.bash-completion
87116  sudo mv winetricks.bash-completion /usr/share/bash-completion/completions/winetricks

- Descomprimir PowerCommsV.zip y move a /home/vmonge/.wine/drive_c/users/vmonge/AppData/Local
- Launcher on ~/.local/share/applications/PowerComms.desktop:

[Desktop Entry]
Type=Application
Name=PowerComms
Exec=/home/vmonge/PowerComms/launcher.sh
Icon=/home/vmonge/PowerComms/icon.ico
chmod +x /home/vmonge/PowerComms/launcher.sh

<!--/home/vmonge/PowerComms/launcher.sh

#!/bin/bash
user=vmonge
wine /home/${user}/.wine/drive_c/users/${user}/AppData/Local/PowerCommsV/PowerCommsV.exe &> /dev/null

-->
