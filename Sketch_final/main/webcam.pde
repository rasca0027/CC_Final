import processing.video.*;

class Webcam {
  Capture cam;
  int h;
  
  Webcam(Capture camera) { 
    cam = camera;
    cam.start();  
    h = 20;
  }
  
  
  void camDraw() {
    if (cam.available() == true) {
      cam.read();
    }
    image(cam, -170, 0, 1365, 768);
    //filter(POSTERIZE, 20);
    
    loadPixels();
    
    h += 3;
    if (h >= height-200)
      h = 0;
    
    int n = int(random(5, height - 10)); // line number
    for (int i = width*(n-1); i<=width*(n+5)-1;i++) {
      pixels[i] = color(random(255), random(255), random(255));
    }
    //println(h);
    /*
    for (int i = width*(h-1); i<=width*(h+30)-1;i++) {
      try { pixels[i] = pixels[i+35]; 
    } catch (ArrayIndexOutofBoundException e){
        println("blahblahblah");
      }
    }
    
    for (int i = width*(h+150); i<=width*(h+170)-1;i++) {
      try { pixels[i] = pixels[i+20]; }
      catch (Error e) {
        println("do nothing");
      }
    }*/
    
    updatePixels();
  }
  
  void noise() {
    loadPixels();
    for (int i = 0; i < width * height; i++) {
      color pink = color(int(random(255)));
      pixels[i] = pink;
    }
    updatePixels();
  }
  


}