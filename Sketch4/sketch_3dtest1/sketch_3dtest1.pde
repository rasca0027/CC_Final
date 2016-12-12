// trying to make a face

void setup() {
  size(600,600,P3D);
  background(0);
  lights();
  noStroke();
}

void draw() {
  background(0);
  camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  translate(50, 50, 0);
  
  for(int j=0;j<20;j++){
    pushMatrix();
    for(int i=0; i<20; i++) {
      translate(30- abs(i-10)*1.7, 0, 0);
      if (i==10){
        pushMatrix();
        translate(0, 0, 30 - abs(j*3 - 30));
        sphere(5);
        popMatrix();
      } else if(j==5){
        pushMatrix();
        translate(0, 0, - sin(i)*20 -30); 
        sphere(5);
        popMatrix();
      } else{

        sphere(5);
      }
    }
    popMatrix();
    translate(0, 35- abs(j-10)*1.7, 0);
  }
 

}