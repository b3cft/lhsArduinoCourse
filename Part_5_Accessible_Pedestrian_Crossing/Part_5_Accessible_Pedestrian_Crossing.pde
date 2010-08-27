/**
 * Arduino code for London Hackspace Beginners Arduino Course
 *
 * Traffic Light with Beeping Pedestrian Crossing
 * Follows this sequence.
 * Car Lights green by default
 * Pedestrian Lights red by default
 * Once Pedestrian cross request is pushed:
 * If the pedWaitTime has been exceeded change the light sequence:
 * Cars: Green -> Amber -> Red   -> Amber Flashing -> Green
 * Peds: Red             -> Green -> Green Flashing  -> Red
 * 
 * Road Red and Crossing Green lights stay on for the crossingDelay
 * Transisions (Ambers) stay on for the shortDelay
 *  
 * @author Bob <andy _._ brockhurst $$at$$ b3cft _._ com>
 */
 
/** Define our delay times, in ms */
const int flashDelay  = 250;
const int shortDelay  = 3000;
const int longDelay   = 6000; 
const int pedWaitTime = 10000;

/** Define our LED pins */
const int roadRedPin       = 2;
const int roadAmberPin     = 3;
const int roadGreenPin     = 4;
const int crossingRedPin   = 5;
const int crossingGreenPin = 6;

/** Define Crossing Request button */
const int crossingRequestPin = 7;

/** Define the piezo pin */
const int sounderPin = 8;

/** Define the pin for the motor driving transistor. Note a PWM output */
const int spinnerPin   = 9;

/** Define the speed for the motor. 0->255 is the valid range */
const int spinnerSpeed = 128;

/** Define the Crossing beeping setting */
const int crossingTone = 300;

/** How long each individual beep lasts */
const int crossingToneDuration = 150;

/** This variable will store the last time the button was pressed for a crossing */
unsigned long lastCrossing;

/** This variable will be set to true when someone requests to cross */
boolean requestCrossing;

/**
 * Set all the LED pins to output and the button to input.
 * Initialise all the LEDs to their starting states.
 */
void setup() {
  
  pinMode(roadRedPin, OUTPUT);
  pinMode(roadAmberPin, OUTPUT);
  pinMode(roadGreenPin, OUTPUT);
  
  pinMode(crossingRedPin, OUTPUT);
  pinMode(crossingGreenPin, OUTPUT);
  
  pinMode(crossingRequestPin, INPUT);
  
  pinMode(sounderPin, OUTPUT);
  pinMode(spinnerPin, OUTPUT);
 
  digitalWrite(roadRedPin, LOW); 
  digitalWrite(roadAmberPin, LOW); 
  digitalWrite(roadGreenPin, HIGH); 
  digitalWrite(crossingRedPin, HIGH);
  digitalWrite(crossingGreenPin, LOW);
  
  digitalWrite(spinnerPin, LOW);
}

/** Loop until we have a crossingRequest  */
void loop() {
   if (HIGH ==  digitalRead(crossingRequestPin)) {
    requestCrossing = true;
  }

  if (true == requestCrossing && pedWaitTime < (millis() - lastCrossing)) {
    doCrossing();
    lastCrossing    = millis();
    requestCrossing = false;
  }
}

/**
 * This function actually performs the light changes for the crossing
 */
void doCrossing() {
  unsigned long start;
  
  /** Change the yellow LED to on for the road */
  digitalWrite(roadAmberPin, HIGH);
  digitalWrite(roadGreenPin, LOW);
  delay(shortDelay);
  
  /** Change the road LED to red and pedestrian to green and start the spinner */
  digitalWrite(roadAmberPin, LOW);
  digitalWrite(roadRedPin, HIGH);
  digitalWrite(crossingRedPin, LOW); // ped red off
  digitalWrite(crossingGreenPin, HIGH); // ped green on
  analogWrite(spinnerPin, spinnerSpeed);

  
  start = millis();
  while((millis()-start) < longDelay) { 
    beep(crossingTone, crossingToneDuration);
    delay(crossingToneDuration);
  } 
  
  /** Flash the pedestrian crossing and road amber and make our beeping and stop the spinner */
  digitalWrite(roadRedPin, LOW);
  analogWrite(spinnerPin, 0);
  for (int x=0; x<10; x++) {
    digitalWrite(roadAmberPin, HIGH);
    digitalWrite(crossingGreenPin, HIGH);
    delay(flashDelay);
    digitalWrite(roadAmberPin, LOW);
    digitalWrite(crossingGreenPin, LOW);
    delay(flashDelay);
  }

  /** Set the pedestrian crossing red light on and the road green light on */
  digitalWrite(crossingRedPin, HIGH);
  digitalWrite(roadGreenPin, HIGH);
}

/**
 * Make a beep on the speaker for the specified duration of a certain tone.
 * Please note the delays are microseconds not milliseconds, so we multiply 
 * the duration by 1000 to scale up to millseconds.
 */
void beep(int tone, int duration) {
  for (long i = 0; i < duration * 1000L; i += tone * 2) {
    digitalWrite(sounderPin, HIGH);
    delayMicroseconds(tone);
    digitalWrite(sounderPin, LOW);
    delayMicroseconds(tone);
  }
}
