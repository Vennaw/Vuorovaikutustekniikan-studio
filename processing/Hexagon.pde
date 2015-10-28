class Hexagon {
  float x, y, radi;
  float angle = 360.0 / 6;
  float similarity;
  int picDiameter;
  PImage img;
  boolean isInside = false;
  boolean visible = false;
  string artistID;
  boolean hoover = false;
  
  Hexagon(float cx, float cy, float r) {
    x=cx;
    y=cy;
    radi=r;
    picDiameter = (int)radi * 2;
    similarity = 0;
  }

  void display() {
    beginShape();
    for (int i = 0; i < 6; i++) {
      vertex(x + radi * cos(radians(angle * i)), 
      y + radi * sin(radians(angle * i)));
    }
    colorMode(RGB, 255);
    fill(75,250,40, this.similarity * 255);
    if (hoover){
      fill(100,50,50,150);
    }
    if(img){
      imageMode(CENTER);
      image(img, x, y, picDiameter/1.6, picDiameter/1.6);
    }
    
    endShape(CLOSE);
  }

  void setArtist(id, imgurl){
    this.artistID = id;
    this.img = loadImage(imgurl, "png");
    getSimilarityIndex(this, id);
  }

  void setSimilarityIndex(index){
    this.similarity = index;
  }
  
  void hoovers() {
  }
  
  boolean isInside() {
    float xDist = abs(x - mouseX);
    float yDist = abs(y - mouseY);
    if (xDist < (radi - 15) && yDist < (radi - 15)){
    return true;
    } else {
    return false;
    }
  }
  
}  

