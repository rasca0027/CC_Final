PFont font;
int counter = 0;
int state = 0;
int x = 50;

void setup(){
  size(600, 600);
  font = createFont("lunchds.ttf", 32);
  textFont(font);
  fill(0);
  frameRate(5); 
}

void draw() {
  background(200);
  
  
  if (mousePressed){
    counter ++;
  }
  
  if (counter > 0)
    state = 1;
    
  
  if (state == 1){
  // start initiating
    switch(counter % 3){
      case 0:
        text("handshake initiating ...", 100, 100);
      case 1:
        text("handshake initiating .", 100, 100);
      case 2:
        text("handshake initiating ..", 100, 100);
    }
    sendSyn();
    
  }
  
  
}

void mouseReleased(){
  counter = 0;
  state = 0;
}

void sendSyn() {
  noFill();
  strokeWeight(5);
  text("SYN", x, 240);
  rect(x, 250, 50, 40);
  x += 10;
}