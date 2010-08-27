/**
 * Arduino code for London Hackspace Beginners Arduino Course
 *
 * Traffic Light with Pedestrian Crossing
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

  digitalWrite(roadRedPin, LOW); 
  digitalWrite(roadAmberPin, LOW); 
  digitalWrite(roadGreenPin, HIGH); 
  digitalWrite(crossingRedPin, HIGH);
  digitalWrite(crossingGreenPin, LOW);
  
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
  
  /** Change the yellow LED to on for the road */
  digitalWrite(roadAmberPin, HIGH);
  digitalWrite(roadGreenPin, LOW);
  delay(shortDelay);
  
  digitalWrite(roadAmberPin, LOW);
  digitalWrite(roadRedPin, HIGH);
  digitalWrite(crossingRedPin, LOW); // ped red off
  digitalWrite(crossingGreenPin, HIGH); // ped green on
  delay(longDelay); 
  
  /** Flash the pedestrian crossing and road amber */
  digitalWrite(roadRedPin, LOW);
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

