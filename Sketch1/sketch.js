var capture;
var val = 0;
var val2;

function setup() {
  createCanvas(640, 480);
  capture = createCapture(VIDEO);
  capture.size(640, 480);
  capture.hide();
  colorMode(HSB);
}


function draw() {
  loadPixels();
  capture.loadPixels();
  
  val = (frameCount) % height;
  val2 = random(0, height);
  
  background(255);
  image(capture, 0, 0, 640, 480);
  
  fill(100, 0, 0);
  ellipse(100, 100, 100, 100);
  
  for(var y = 0; y < height; y++) {
    for(var x = 0; x < width; x++){
      // here we are going over the image's pixels
      var pix = (x + y * width) * 4;  // pulling out one pixel at a time to work with
      var h = capture.pixels[pix  ];  // then pulling out the red value
      var s = capture.pixels[pix + 1]; // green value
      var b = capture.pixels[pix + 2]; // blue value
      
      if ((h > 230) && (h <250)) {
        h = 0;
      }
      
      
      if ((y >= val) && (y <= val + 3)) {
        pixels[pix   ] = random(255);
        pixels[pix + 1] = random(255);
        pixels[pix + 2] = random(255);
        pixels[pix + 3] = 255;
      } else if ((y >= val2) && (y <= val2 + 20)) {

        pixels[pix] = capture.pixels[pix-52];
        pixels[pix + 1] = capture.pixels[pix-51];
        pixels[pix + 2] = capture.pixels[pix-50];
        pixels[pix + 3] = 255;

      } else {
        pixels[pix   ] = h;
        pixels[pix + 1] = s;
        pixels[pix +2 ] = b;
        pixels[pix + 3] = 255;
      }
      
    }
  }
  //update those bad turkies
  updatePixels(); // the entire canvas
  
  filter(POSTERIZE, 8);
  
  
}
