# GENERAL


## Acceso ssh

ssh root@IP

usuario root
password root

## Encender/apagar luces

echo 1 > /sys/class/leds/drive_light/brightness
echo 0 > /sys/class/leds/drive_light/brightness

echo 1 > /sys/class/leds/pass_light/brightness
echo 0 > /sys/class/leds/pass_light/brightness

## MACS

05
MAC Address: 00:25:CA:7E:09:A7 (LS Research)

07
MAC Address: 00:25:CA:7E:09:87 (LS Research)

# SFTP AWS

From https://bobafett/sw-area/embedded-linux/new-developments/valans/valans_doc

## AWS SERVER:

1. SFTP URL: [s-c29acdf3d6b94277b.server.transfer.eu-west-3.amazonaws.com](s-c29acdf3d6b94277b.server.transfer.eu-west-3.amazonaws.com)
2. Acceso por claves ([aws_keys folder](aws_keys/keys.md))
3. **LOGS**: los logs de remote updates indican las versiones de los paquetes y los podemos encontrar en la carpeta ***/sftp-valans-moto/valans/logs***. Example:
```
Date
Thu 03 Aug 2023 12:56:17 PM UTC
Installed Packets
pebase-valans	1.1-3
pedisplay-valans	1.0-9
pefirmware-valans	1.0-0
peupdate-valans	1.0-4
Uptime
 12:56:18 up  6:30,  0 users,  load average: 2.88, 2.60, 2.51
```
4. **PAQUETES DE ACTUALIZACIÓN**: Los paquetes .deb con los que se auto-actualizan las motos se encuentran en ***/sftp-valans-moto/valans/sw/releases/last/bups***. Para actualizarlos a mano los copiaríamos al display y ejecutaríamos:
```bash
$ dpkg -i XXX.deb
```

## AWS SERVER KEY FILES:

User: valans
1. aws_keys/id_rsa: clave SSH privada
2. aws_keys/id_rsa.pub: clave SSH publica
3. aws_keys/id_rsa.ppk: clave tipo PuTTY
