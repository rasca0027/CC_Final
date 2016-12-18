class Bg {
  int x, y;
  char c;
  
  Bg (int x_pos) {
    x = x_pos;
    y = 150;
    c = (char)(int(random(2)) + 48);
    text(c, x, y, 100);
  }
  
  void update() {
    text(c, x, y, -100);
    y += 15;
  }

}