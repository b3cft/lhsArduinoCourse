/**
 * Arduino code for London Hackspace Beginners Arduino Course
 *
 * Basic Traffic Light
 * Follows this sequence.
 * Red -> Red & Amber -> Green -> Amber
 * Red and Green lights stay on for the LongDelay
 * Transitions (Ambers) stay on for the ShortDelay
 *  
 * @author Bob <andy _._ brockhurst $$at$$ b3cft _._ com>
 */

/** Define our delay times, in ms */
const int shortDelay = 2000;
const int longDelay  = 5000; 

/** Define which pins to use for the LEDs */
const int redPin    = 2;
const int yellowPin = 3;
const int greenPin  = 4;

/**
 * Set all of our LED pins to be outputs. 
 * Make sure they are all off to start with.
 */
void setup() {

  pinMode(redPin, OUTPUT);
  pinMode(yellowPin, OUTPUT);
  pinMode(greenPin, OUTPUT);

  digitalWrite(redPin, LOW); 
  digitalWrite(yellowPin, LOW);
  digitalWrite(greenPin, LOW); 
}

/**
 * Perform our sequence. Start with Red, we don't want accidents.
 */
void loop() {
  
  /** Red on, then wait */
  digitalWrite(redPin, HIGH); 
  delay(longDelay);
  
  /** Amber on and a short delay */
  digitalWrite(yellowPin, HIGH);
  delay(shortDelay);
  
  /** Red and Amber off, Green on, then our long delay */
  digitalWrite(redPin, LOW); 
  digitalWrite(yellowPin, LOW);
  digitalWrite(greenPin, HIGH);
  delay(longDelay);
  
  /** Green off, Amber on and a short delay */
  digitalWrite(greenPin, LOW);
  digitalWrite (yellowPin, HIGH);
  delay(shortDelay);
  
  /** Amber off, and then back to the top of the loop for Red on. */
  digitalWrite(yellowPin, LOW);
  
}


