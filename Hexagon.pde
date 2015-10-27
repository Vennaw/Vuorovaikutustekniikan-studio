class Hexagon {
  float x, y, radi;
  float angle = 360.0 / 6;
  int picDiameter;
  PImage img;
  boolean isInside = false;
  boolean visible = false;
  string artistID;
  boolean hoover = false;
  string artistName;
  
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
    
    if(img){
      imageMode(CENTER);
      image(img, x, y, picDiameter/1.6, picDiameter/1.6);
    }

    if (hoover){
      fill(100,50,50,150);
    } else {
      noFill();
    }
    
    endShape(CLOSE);
    if(hoover){
      fill(255);
      textSize(14);
      textAlign(CENTER, CENTER);
      rectMode(CENTER);
      text(artistName, x - picDiameter/3.2, y - picDiameter/3.2, picDiameter/1.6, picDiameter/1.6);
    }
  }

  void setArtist(id, imgurl){
    this.artistID = id;
    this.img = loadImage(imgurl, "png");
  }
  
  void hoovers() {
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

