nvm install 21
nvm use 21

#
cd OCPP_Node_2.0.1_Simulator
npm install -> instalar paquetes/dependencias
npx tsc -> transpilar el typescrypt, se genera en el public/dist
(npx tsc --watch) para traspilar si hace falta automaticamente
npm start -> arranca la aplicacion

*hay que cambiar las rutas absolutas

http://localhost:3001/ se pueden enviar comandos

#
cd pe-ocpp-charger-client
npx ts-node main.ts -> lanza el typescript directamente sin compilarlo
