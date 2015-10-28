class Button {
  int x, y;
  String label;
  int bW, bH;   //button width & height
  
  Button(int x, int y, String label) {
    this.x = x;
    this.y = y;
    bW = 150;
    bH = 90;
    this.label = label;
  }

  void draw() {
    fill(200);
    if (over()) {
      fill(255);
    }
    rect(x, y, bW, bH);
    fill(0);
    textAlign(CENTER);
    text(label, x + x*1.2, y + bH/2 + 5);
  }

  boolean over() {
    if (mouseX >= x && mouseY >= y && mouseX <= x + bW && mouseY <= y + bH) {
      return true;
    }
    return false;
  }
  
}

