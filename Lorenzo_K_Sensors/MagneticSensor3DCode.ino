#include "Adafruit_MLX90395.h"
#include "Wire.h"

Adafruit_MLX90395 proximal_sensor = Adafruit_MLX90395();
Adafruit_MLX90395 distal_sensor = Adafruit_MLX90395();

void setup(void){
  
// SET UP SERIAL COMMUNICATION
 
  Serial.begin(9600);
  while (!Serial) {
      delay(10);
  }

// PROXIMAL SENSOR 

// Find proximal sensor on I2C Bus
  if (! proximal_sensor.begin_I2C(0xD)) {          // hardware I2C mode, can pass in address & alt Wire
    Serial.println("No sensor found ... check your wiring?");
    while (1) { delay(10); }
  }

// Set proximal sensor OSR 
  proximal_sensor.setOSR(MLX90395_OSR_8);

// Get proximal sensor resolution
  proximal_sensor.setResolution(MLX90395_RES_17);

// DISTAL SENSOR 

// Find distal sensor on I2C Bus
  if (! distal_sensor.begin_I2C(0xC)) {          // hardware I2C mode, can pass in address & alt Wire
    Serial.println("No sensor found ... check your wiring?");
    while (1) { delay(10); }
  }

// Set distal sensor OSR 
  distal_sensor.setOSR(MLX90395_OSR_8);

// Get distal sensor resolution
  distal_sensor.setResolution(MLX90395_RES_17);
 
}
void loop(void) {

  // Sample XYZ magnetic field vectors for proximal sensor, print to serial line
  
  sensors_event_t proximal_event; 
  proximal_sensor.getEvent(&proximal_event);
  Serial.print(proximal_event.magnetic.x);
  Serial.print(",");
  Serial.print(proximal_event.magnetic.y);
  Serial.print(",");
  Serial.print(proximal_event.magnetic.z);
  Serial.print(",");

  // Sample XYZ magnetic field vectors for distal sensor, print to serial line

  sensors_event_t distal_event; 
  distal_sensor.getEvent(&distal_event);
  Serial.print(distal_event.magnetic.x);
  Serial.print(",");
  Serial.print(distal_event.magnetic.y);
  Serial.print(",");
  Serial.print(distal_event.magnetic.z);
  Serial.println(",");

}
