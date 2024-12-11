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



# Montar sistema para pruebas

1.- ~/Workspace/11_OCPP/**OCPP_Node_2.0.1_Simulator**

- aseguramos usar la version correcta de node: $ nvm use 21
- cogemos la rama adecuada (ahora es develop)
- traspilamos usando: $ npx tsc
- arrancamos: $ npm start

2.- ~/Workspace/11_OCPP/**pe-ocpp-charger-client**

- aseguramos usar la version correcta de node: $ nvm use 21
- cogemos la rama adecuada (ahora es develop)
- aseguramos las dependencias están satisfechas: $ npm install
- arrancamos: $ npx ts-node main.ts

3.- ~/Workspace/11_OCPP/pe_ocpp_manager **SNIFFER**

4.- ~/Workspace/superproject_linux/lib/pe_billing_service **event_generator**

5.- ~/Workspace/11_OCPP/pe_ocpp_manager **pe_ocpp_manager**

6.- ~/Workspace/superproject_linux/lib/pe_ipc_broker **pe-broker-ipc-service**

## Pruebas 

### 1.- Broker - Server

1.1.- **event_generator** (prueba status): 4 send status; charge point 6; status 3 charging
1.2.- **manager**

IN >>> msg_handler: type: 4	group: 64
ACK recv: StatusNotification
[{}]
[SIO:ACK] StatusNotification

1.3.- **client**

Apr 24 12:08:26.439]-INTMSG- Received from Manager: {"event":"StatusNotification","data":{"connectorId":6,"connectorStatus":"CHARGING","timestamp":1713953306437}}
[Apr 24 12:08:26.439]-PROTOCOL- Received from Manager: [object Object]
[Apr 24 12:08:26.475]-PROTOCOL- Send OCPP Command: StatusNotification (uuid:b12d9b0b-4f41-4a89-acae-291dde0760db)
[Apr 24 12:08:26.476]-COM- Send WS message: [2,"b12d9b0b-4f41-4a89-acae-291dde0760db","StatusNotification",{"evseId":6,"connectorId":6,"timestamp":"2024-04-24T10:08:26.437Z","connectorStatus":"Occupied"}]
[Apr 24 12:08:26.501]-COM- Recv WS message: [3,"b12d9b0b-4f41-4a89-acae-291dde0760db",{}]
[Apr 24 12:08:26.502]-PROTOCOL- Received OCPP command: StatusNotification (uuid:b12d9b0b-4f41-4a89-acae-291dde0760db)


1.4.- **server simulator**

Apr 24th 24, 12:08:26 (6) - StatusNotificationRequest received.
Apr 24th 24, 12:08:26 (7)
{
  evseId: 6,
  connectorId: 6,
  timestamp: '2024-04-24T10:08:26.437Z',
  connectorStatus: 'Occupied'
}
Apr 24th 24, 12:08:26 (6) - Sending StatusNotificationResponse...
Apr 24th 24, 12:08:26 (7)


### 2.- Server - Broker

2.1- http://localhost:3001/ y en la Command console:

[
    2,
    "1536411756664",
    "RequestStartTransaction",
    {
        "remoteStartId": 1,
        "idToken": {
            "idToken": "0",
            "type": "Central"
        },
        "evseId": 3
    }
]

[
  2,
  "1536411756669",
  "RequestStopTransaction",
  {
  		"transactionId": "1723188952-003051"
  }
]

2.2.- **server**

Apr 24th 24, 12:10:56 (6) - Validating a custom message...
Apr 24th 24, 12:10:56 (7)
{
  ocppVersion: '2.0.1',
  message: [
    2,
    '1536411756664',
    'RequestStartTransaction',
    {
      remoteStartId: 1,
      idToken: { idToken: '0', type: 'Central' },
      evseId: 6
    }
  ]
}
Apr 24th 24, 12:10:56 (6) - Protocol detected: 2.0.1
Apr 24th 24, 12:10:56 (6) - Message passed validation.
Apr 24th 24, 12:10:56 (6) - Front end sent a custom message. Sending it to the charging station...
Apr 24th 24, 12:10:56 (7)
[
  2,
  '1536411756664',
  'RequestStartTransaction',
  {
    remoteStartId: 1,
    idToken: { idToken: '0', type: 'Central' },
    evseId: 6
  }
]
Apr 24th 24, 12:10:56 (6) - Custom message response received.
Apr 24th 24, 12:10:56 (7)
{ status: 'Accepted' }


2.3.- **client**

[Apr 24 12:10:56.375]-COM- Recv WS message: [2,"bbe45005-14ef-4d4a-a02d-19c57c8f92c4","RequestStartTransaction",{"remoteStartId":1,"idToken":{"idToken":"0","type":"Central"},"evseId":6}]
[Apr 24 12:10:56.375]-PROTOCOL- Received OCPP command: RequestStartTransaction (uuid:bbe45005-14ef-4d4a-a02d-19c57c8f92c4)
[Apr 24 12:10:56.398]-INTMSG- Send to Manager: {"event":"RequestStartTransaction","data":{"idToken":"0","idTokenType":"Central","connectorId":6,"remoteStartId":1,"chargingProfile":null}}
[Apr 24 12:10:56.399]-INTMSG- Manager responded: {"event":"RequestStartTransaction","data":{"status":"Accepted"}}
[Apr 24 12:10:56.400]-PROTOCOL- Send OCPP Command:  (uuid:bbe45005-14ef-4d4a-a02d-19c57c8f92c4)
[Apr 24 12:10:56.400]-COM- Send WS message: [3,"bbe45005-14ef-4d4a-a02d-19c57c8f92c4",{"status":"Accepted"}]


2.4.- **manager**


New message recv: RequestStartTransaction{"chargingProfile":null,"connectorId":6,"idToken":"0","idTokenType":"Central","remoteStartId":1}
Unique string from '/pe_brk_output_topics_queue' to '/pe_brk_output_topics_queue_pe_ocpp_manager'

>>> remotely [publisher|add|NAME:/pe_brk_output_topics_queue_pe_ocpp_manager|TP:2|GR:'65536|ID:0x7f7e4000cee0|MAX:100|SZ:96]sizeof(info)='288', result: 
OK!!

>>> locally [/pe_brk_output_topics_queue_pe_ocpp_manager|2|65536]
	[publisher|add|NAME:/pe_brk_output_topics_queue_pe_ocpp_manager|TP:2|GR:'65536|ID:0x7f7e4000cee0|MAX:100|SZ:96] result: OK!!
@ brk_msg_put 'OK' qid '0x7f7e4000cee0' T: '2' GR: '65536'
