import gab.opencv.*;
import processing.video.*;
import java.awt.*;
PImage src, dst, gray;
Capture video;
OpenCV opencv;
ArrayList<Contour> contours;
ArrayList<Contour> polygons;
import processing.sound.*;
SoundFile sample;

void setup() {
  size(1280, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  //opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  // Load a soundfile from the /data folder of the sketch and play it back
  sample = new SoundFile(this, "sample.wav");
  

  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);
  opencv.gray();
  gray = opencv.getOutput();
  opencv.threshold(100);
  dst = opencv.getOutput();

  contours = opencv.findContours();
  //println("found " + contours.size() + " contours");

  image(gray, 640, 0 );
  image(dst, 0, 0 );
  
  noFill();
  strokeWeight(3);
  
  for (Contour contour : contours) {
    stroke(0, 255, 0);
    contour.draw();
    
    stroke(255, 0, 0);
    ArrayList<PVector> points = contour.getPolygonApproximation().getPoints();
    println(points.size());
    if (points.size() <= 10){
      beginShape();
      for (PVector point : points) {
        vertex(point.x, point.y);
      }
      endShape();  
    }
  }


  
}

void captureEvent(Capture c) {
  c.read();
}

void mousePressed() {
  sample.play();
}