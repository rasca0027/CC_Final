import processing.serial.*;
Serial myPort;     
PFont font;
boolean touch = false;
int phase = 1;
HandShake hand = new HandShake();
FaceCloud face;
 

void setup(){
  size(1024, 768, P3D);
  font = createFont("lunchds.ttf", 32);
  textFont(font);
  fill(0);
  frameRate(10); 
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[0], 9600);
}

void draw() {
  
  // read data from serial port  
  while (myPort.available() > 0) {
    char inByte = myPort.readChar();
    //println(inByte);
    if (inByte == '1') {
      touch = true;
    } else if (inByte == '0') {
      touch = false;
      hand.touchReleased();
    }
  }
  // handshaking phase  
  if (phase == 1) {
    hand.shake(touch);
  
    if (hand.finished) {
      text("CONNECTION BUILT", 250, height/2);
      phase = 2;
      face = new FaceCloud();
    }
  }
  
  // AI face phase
  if (phase == 2) {
    face.draw2();
  }
    
}