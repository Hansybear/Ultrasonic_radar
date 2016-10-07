import processing.serial.*;
import java.util.Arrays;
String serial;
Serial port;
int end = 10; // Keycode for line ending
int lineRadius = 1000;
int distances[];

void setup() {
  distances = new int[181];
  for(int i=0; i<distances.length; i++) {
    distances[i] = 0;
  }
  size(800, 800);
  port = new Serial(this ,Serial.list()[0], 57600);
  //System.out.print(Arrays.toString(Serial.list()));
  port.clear();
  serial = port.readStringUntil(end);
  serial = null;
}


void draw() {
  background(35);
  makeGrid();
  while(port.available()>0) {
    serial = port.readStringUntil(end);
  }
  if(serial != null) { 
    String[] a = split(serial, ',');
    println(a[0]);
    println(a[1]);
    int angle = Integer.parseInt(a[0].trim());
    //float rads = PI*angle/180.0;
    if(angle<=180) {
      distances[angle] = Integer.parseInt(a[1].trim());
    }
    drawDistances(angle);
  }
}

void makeGrid() {
  fill(0);
  ellipse(width/2, 0, width, height);
  
  stroke(100, 100, 125);
  noFill();
  ellipse(width/2, 0, width/4, height/4);
  ellipse(width/2, 0, width/2, height/2);
  ellipse(width/2, 0, 3*width/4, 3*height/4);
  for(int i=0; i<180; i+=30) {
    float rads = PI*i/180;
    line(width/2, 0, (width/2)-lineRadius*cos(rads), lineRadius*sin(rads));
  }
}
// Tægn prikkan
void drawDistances(int currentAngle) {
  fill(100, 200, 100);
  int scaling = 5;
  for(int i=0; i<distances.length; i++) {
    int dist = distances[i];
    float rads = PI*i/180;
    int xPos = (width/2)-round(scaling*dist*cos(rads));
    int yPos = round(scaling*dist*sin(rads));
    ellipse(xPos, yPos, 5, 5);
    
  }
}