import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
boolean flag;
PImage hand;
int y = 300;

void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  hand = loadImage("hand.png");
  flag = true;  

  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);
  if (flag) {
    image(video, 0, 0 );
  }
  else {
    image(video, -32, -24, 384, 288);
    image(hand, 0, y, 240, 320);
    y -= 1;
    if (y <= 120) {
      y = 120;
    }
  }
}

void captureEvent(Capture c) {
  c.read();
}

void mousePressed() {
  flag = !flag;
}