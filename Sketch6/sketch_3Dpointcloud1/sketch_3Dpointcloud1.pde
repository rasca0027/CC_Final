PShape boxCloud;
ArrayList<Bg> listofbgs = new ArrayList<Bg>();
String filename;
 
void setup() {
  size(1024, 768, P3D);
  smooth();
  frameRate(10);
  filename = "1";
}
 
void draw() {
  background(0);
  
  camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  
  backing();
  for (int i=0; i<listofbgs.size(); i++) {
    listofbgs.get(i).update();
  }
  
  translate(width/2-75, height/2-150, 520);
  rotateZ(PI/12);
  //translate(0, -50, 0);
  //shape(boxCloud);
  readFile();
  
}


void mousePressed() {
  filename = "171";
}

void mouseReleased() {
  filename = "1";
}
 
 
void readFile() {
  
  String[] raw = loadStrings(filename + ".csv");
  
  for(int i = 0; i < raw.length;i++){
    
    //if (int(random(5)) %2 == 0)
    //continue;
    //if (i % 2 == 0)
    //  continue;
    
    // For each line we're going to divide up each paramety
    String[] thisLine = split(raw[i], ',');
    // Now we will make a variable for each parameter specified in the file. They will be decimal values. 
    float x = float(thisLine[0]);
    float y = float(thisLine[1]);
    float z = float(thisLine[2]);
    int intensity = int(thisLine[3]);
    
    // trim
    if ((z < -107) || (y < 80) || (y > 230) || (intensity <= 17))
      continue;
    
    //stroke(intensity*1.1,intensity*1.6,200,255);
    //stroke(255, 255, 255);
    stroke(0, intensity * 1.5, 0);
    // Here we'll draw a little line for each point this is much faster than a more complex object and we'll be drawing a lot of them
    line(x, y, z, x+1, y+1, z+1);
    /* too slow
    pushMatrix();
    translate(x, y, z);
    sphere(1);
    popMatrix();
    */
  }
}
 
 
void backing() {
  int x = int(random(1000));
  fill(0, 255, 0, 150);
  
  //text("a", x, 150, 100);
  Bg a = new Bg(x);
  listofbgs.add(a);
  
}