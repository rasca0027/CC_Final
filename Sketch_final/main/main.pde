import processing.serial.*;
import processing.video.*;
import ddf.minim.*;

Serial myPort;     
PFont font;
boolean touch = false;
int phase = 0;
HandShake hand;
FaceCloud face;
NoiseScreen ns = new NoiseScreen();
Minim minim;
AudioPlayer player, come1, come2, bye;
Webcam camera;
int start, start2;
String[] cameras;
boolean byesaid = false;
 

void setup(){
  size(1024, 768, P3D);
  font = createFont("lunchds.ttf", 32);
  textFont(font);
  fill(0);
  frameRate(10); 
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[0], 9600);
  // load sound file
  
  minim = new Minim(this);
  player = minim.loadFile("AIvoice.mp3");
  come1 = minim.loadFile("come1.mp3");
  come2 = minim.loadFile("come2.mp3");
  bye = minim.loadFile("bye.mp3");
  hand = new HandShake(come1, come2);
  camInit();
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
  
  println(touch);
  
  // initial phase
  if (phase == 0) {
    camera.camDraw();
    
    if (touch) {
      start2 = millis();
      phase = 10;
    }
  }
  
  else if (phase == 10) {
    camera.noise();
    if (millis() - start2 > 800)
      phase = 1;
  }
  
  // handshaking phase  
  else if (phase == 1) {
    hand.shake(touch);
  
    if (hand.finished) {
      fill(0, 204, 0);
      text("CONNECTION BUILT", 400, height/2);
      fill(0);
      phase = 2;
      face = new FaceCloud(player);
    }
  }
  
  // AI face phase
  else if (phase == 2) {
    if (!face.played) {
      face.playVoice();
    }
    face.draw2();
    
    if (face.fn) {
      phase = 3;
      start = millis();
    }
  } // end phase 2
  
  else if (phase == 3) {
    if ((millis() - start) < 3000) {
      if (!byesaid) {
        byesaid = true;
        bye.play();
      }
      ns.grayScreen();
    }
    else {
      phase = 0;
      hand.state = 0;
      hand.finished = false;
      hand.x = 250;
      hand.error = false;
      hand.counter = 0;
      face.played = false;
      face.x = 0;
      face.fn = false;
      face.player.rewind();
    }
  }
    
    
}


void camInit() {
  cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
  }
  Capture cam = new Capture(this, cameras[0]);
  camera = new Webcam(cam);
}