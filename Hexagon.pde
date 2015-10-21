class Hexagon {
  float x, y, radi;
  float angle = 360.0 / 6;
  int picDiameter;
  PImage img;
  boolean isInside = false;
  boolean visible = false;
  string artistID;
  
  Hexagon(float cx, float cy, float r) {
    x=cx;
    y=cy;
    radi=r;
    picDiameter = (int)radi * 2;
  }

  void display() {
    beginShape();
    for (int i = 0; i < 6; i++) {
      vertex(x + radi * cos(radians(angle * i)), 
      y + radi * sin(radians(angle * i)));
    }
    colorMode(RGB, 255);
    noFill();
    if(img){
      imageMode(CENTER);
      image(img, x, y, picDiameter/1.6, picDiameter/1.6);
    }
    
    endShape(CLOSE);
  }

  void setArtist(id, imgurl){
    this.artistID = id;
    this.img = loadImage(imgurl, "png");
  }
  
  void hoovers() {
    if (isInside == true) {
      stroke(0);
    } else noStroke();
  }
  
  boolean isInside() {
    float xDist = abs(x - mouseX);
    float yDist = abs(y - mouseY);
    if (xDist < (radi - 10) && yDist < (radi - 10)){
    return true;
    } else {
    return false;
    }
  }
  
}  

