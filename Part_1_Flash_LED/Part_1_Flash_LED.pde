/**
 * Arduino code for London Hackspace Beginners Arduino Course
 *
 * @author Bob <andy _._ brockhurst $$at$$ b3cft _._ com>
 */

/** Digital Output Pin for LED */
const int ledPin = 0;

/** Time for LED to be On in ms */
const int onDelay = 1000;

/** Time for LED to be Off in ms */
const int offDelay = 1000;

/**
 * The Setup Function is only run once, when the Arduino is powered on or after it is reset.
 *
 * This initialised the state of the Ardunio, in this case all we want
 * is to set our ledpin to be set to Output mode.
 */
void setup() {
  pinMode(ledPin, OUTPUT);
}

/**
 * Once the setup() function has excuted, the loop function will run forever 
 * or until the power is removed or the Arduino is reset.
 *
 * Here we set the LED pin HIGH (on) then wait our defined 'on' delay, 
 * then set the LED pin LOW (off) and wait our 'off' delay.
 */
void loop() {
  
  digitalWrite(ledPin, HIGH);
  delay(onDelay);
  
  digitalWrite(ledPin, LOW);
  delay(offDelay);
  
}

