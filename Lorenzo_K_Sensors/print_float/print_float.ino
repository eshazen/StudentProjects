//
// send two (X,Y,Z) values as floats at timer-controlled interval,
// preceded by a sentinel value (23)
//
// send a two-byte synchronization sequence (57, 91) at start-up
//
// uses arduino-timer library v3.01
//

#include <arduino-timer.h>

auto timer = timer_create_default(); 

static const int delay_ms = 10;   // delay between transmissions

static float pts[6];
static uint8_t sentinel = 23;
uint8_t sync[] = { 57, 91 };
uint8_t tick;

float updat(float x) {
  return (float)random(1,100)/(float)random(1,100);
}

bool timer_callback( void *arg) {

  for( int i=1; i<6; i++)
    pts[i] = updat(pts[i-1]);
  pts[0] = updat(pts[5]);

  Serial.write( &sentinel, 1);
  Serial.write( (byte *)pts, sizeof(pts));

  tick++;

  if( tick & 1)
    digitalWrite( LED_BUILTIN, HIGH);
  else
    digitalWrite( LED_BUILTIN, LOW);

  return true;
}


void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  Serial.setTimeout( 1000000);
  pinMode( LED_BUILTIN,OUTPUT);
  pts[0] = 22./7.;

  Serial.write( sync, 2);
  delay(100);

  timer.every( delay_ms, timer_callback);
}



void loop() {
  timer.tick();  
}
