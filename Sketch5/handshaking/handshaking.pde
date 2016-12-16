PFont font;
int counter = 0;
int state = 0;
int x = 100;
boolean error;
boolean finished;

void setup(){
  size(600, 600);
  font = createFont("lunchds.ttf", 32);
  textFont(font);
  fill(0);
  frameRate(5); 
  error = false;
  finished = false;
}

void draw() {
  background(200);
  println(x);
  
  if (finished) {
    text("CONNECTION BUILT", 150, height/2);
  }
  
  if ((mousePressed) && (!finished)){
    counter ++;
    
    // start initiating
    switch(counter % 3){
      case 0:
        text("handshake initiating .", 100, 100);
        break;
      case 1:
        text("handshake initiating ..", 100, 100);
        break;
      case 2:
        text("handshake initiating ...", 100, 100);
        break;
    }
    
    error = false;
  }
  
  if ((error) && (!finished)) {
    // error
    errorOccured();
  }
  
  if ((state == 0) && (counter > 0))
    state = 1;
    
  if ((state == 1)&&(mousePressed)){
    
    if (x >= 450) {
      delay(500);
      state = 2;
    }
    sendSyn();
    
  } // end if state 1
  
  // state 2
  else if ((state == 2) && (mousePressed)) {
    if (x <= 100) {
      delay(500);
      state = 3;
    }
    println("state 2");
    sendSynAck();
    
  } // end if state 2
  
  
  else if ((state == 3) && (mousePressed)) {
    if (x >= 450){
      delay(500);
      state = 4;
      finished = true;
    }
    println("state 3");
    sendAck();
    
  } // end if state 2
  
}

void mouseReleased(){
  counter = 0;
  if ((state == 1) || (state == 3))
    x = 100;
  else
    x = 450;
  error = true;
}

void sendSyn() {
  noFill();
  strokeWeight(5);
  text("SYN", x, 240);
  rect(x, 250, 50, 40);
  x += 15;
}

void sendSynAck() {
  noFill();
  strokeWeight(5);
  text("SYNACK", x - 20, 270);
  rect(x, 280, 50, 40);
  x -= 15;
}

void sendAck() {
  noFill();
  strokeWeight(5);
  text("ACK", x, 300);
  rect(x, 310, 50, 40);
  x += 15;
}

void errorOccured() {
  text("ERROR OCCURED", 180, height/2);
  text("CONNECTION INTERRUPTED", 100, height/2 + 40);
}