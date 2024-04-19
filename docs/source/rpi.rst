SSH:

Esta desactivado por defecto

Para activar SSH en headless mode (sin teclado ni pantalla) hay que montar la SD o la MMC y crear un archivo SSH en el raíz:

touch ssh 



PARA FLASHEAR RPI:

cd Workspace/usbboot/
arranque con el SW1 en la L3 o con el jumper de la placa de entrenamiento puesto
sudo ./rpiboot
esto te monta el storage
luego conb el rpi imager podemos seleccionar la rpi y la imagen