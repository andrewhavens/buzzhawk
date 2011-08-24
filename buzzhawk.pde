#include <SPI.h>
#include <Ethernet.h>

byte mac[] = {  0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
byte ip[] = { 10,116,100,240 };
byte gateway[] = { 10,116,20,1 };
byte subnet[] = { 255,255,0,0 };
byte server[] = { 10,116,100,86 }; //andrew's computer
Client client(server, 4567); //sinatra app is running on port 4567

//fake levels
int italianLevel = 100;
int hairbenderLevel = 80;
int decafLevel = 90;

void setup() {
  Ethernet.begin(mac, ip, gateway, subnet);
  Serial.begin(57600);
  delay(1000);// give the Ethernet shield a second to initialize:
  Serial.println("connecting...");

  if (client.connect()) {
    Serial.println("connected");
    client.println("POST /update-levels?italian=100&hairbender=80&decaf=90 HTTP/1.0");
    client.println();
  } else {
    Serial.println("connection failed");
  }
}

void loop() {
  if (client.available()) {
    char c = client.read();
    Serial.print(c);
  }

  if (!client.connected()) {
    Serial.println();
    Serial.println("disconnecting.");
    client.stop();

    // do nothing forevermore:
    for(;;)
      ;
  }
}



