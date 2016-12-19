class HandShake {
  int state;
  int x;
  boolean error;
  boolean finished;
  int counter;
  
  HandShake () {
  // constructor
    state = 0;
    x = 250;
    error = false;
    finished = false;
    counter = 0;
  }
  
  void shake(boolean touch) {
    background(200);

    if ((touch) && (!finished)){
      counter ++;
      
      // start initiating
      switch(counter % 3){
        case 0:
          text("handshake initiating .", 300, 200);
          break;
        case 1:
          text("handshake initiating ..", 300, 200);
          break;
        case 2:
          text("handshake initiating ...", 300, 200);
          break;
      }
      
      error = false;
    }
    
    if ((state == 0) && (counter > 0))
      state = 1;
      
    if ((state == 1)&&(touch)){
      
      if (x >= 600) {
        delay(500);
        state = 2;
      }
      sendSyn();
      
    } // end if state 1
    
    // state 2
    else if ((state == 2) && (touch)) {
      if (x <= 250) {
        delay(500);
        state = 3;
      }
      //println("state 2");
      sendSynAck();
      
    } // end if state 2
    
    
    else if ((state == 3) && (touch)) {
      if (x >= 600){
        delay(500);
        state = 4;
        finished = true;
      }
      //println("state 3");
      sendAck();
      
    } // end if state 3
    
    
    if ((error) && (!finished) && (state != 0)) {
      // error
      errorOccured();
    }
  
  } // end shake
  
  
  
  void touchReleased(){
    counter = 0;
    if ((state == 0) || (state == 1) || (state == 3))
      x = 250;
    else
      x = 600;
    error = true;
  }
  
  void sendSyn() {
    noFill();
    strokeWeight(5);
    text("SYN", x, 300);
    rect(x, 310, 60, 50);
    x += 10;
  }
  
  void sendSynAck() {
    noFill();
    strokeWeight(5);
    text("SYNACK", x - 20, 360);
    rect(x, 370, 50, 40);
    x -= 10;
  }
  
  void sendAck() {
    noFill();
    strokeWeight(5);
    text("ACK", x, 420);
    rect(x, 430, 50, 40);
    x += 10;
  }
  
  void errorOccured() {
    text("CONNECTION FAIL", width/2 - 100, height/2);
    text("WHY ARE YOU LEAVING", width/2 - 200, height/2 + 50);
  }
}