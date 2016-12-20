class NoiseScreen {

  
  void grayScreen() {
    
    loadPixels();
    for (int i = 0; i < width * height; i++) {
      color pink = color(int(random(255)));
      pixels[i] = pink;
    }
    updatePixels();
  }

}