#include <Servo.h>
#define servoPin 9
#define echoPin 7 // Echo pin
#define trigPin 8 // Trig pin. !important

Servo myservo;
int pos = 0;
long duration, distance; // Mellomlagring av avstand og tid. Duration og distance.
int increasingServo = true;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(57600);
  myservo.attach(servoPin);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
}

void loop() {
  // Vi starter med å sende et signal til avstandsmåleren.
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

// Nå venter vi på signalet tilbake fra sensoren
// 0.1 sekunder timeout
  duration = pulseIn(echoPin, HIGH, 100000);

  // Lyd går i 346 m/s ved 25 c. Det er 0.000346 m/mikrosekund som er 0.0346 cm/mikrosekund
  distance = duration*0.0346/2;
  Serial.print(pos);
  Serial.print(",");
  Serial.print(distance);
  Serial.println();
  if(increasingServo) {
    if(pos<180) {
      pos += 1;
    }else{
      increasingServo = false;
    }
  }else{
    if(pos>0) {
      pos -=1;
    }else{
      increasingServo = true;
    }
  }

  myservo.write(pos);
  
  delay(10);
}
