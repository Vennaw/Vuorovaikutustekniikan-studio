Hexagon[][] hexagon;   

int rad = 60; //size of the hexagon
int hexcountx, hexcounty;


void setup() {
  size(1200, 800);
  smooth();
  background(255);
  frameRate(50); //Specifies the number of frames to be displayed every second.
  hexcountx = (height/(rad));
  hexcounty = (width/(rad));
  hexagon = new Hexagon [hexcountx][hexcounty];
  for (int i = 0; i < hexcountx; i++) {
    for (int j = 0; j < hexcounty; j++) {
      if ((j % 2) == 0) {
        hexagon[i][j] = new Hexagon((3 * rad * i), (.866 * rad * j), rad);
      } 
      else {
        hexagon[i][j] = new Hexagon(3 * rad * (i + .5), .866 * rad * j, rad);
      }
    }
  }
}

void draw() {
  for (int i = 0; i < hexcountx; i ++ ) {     
    for (int j = 0; j < hexcounty; j ++ ) {
      if (hexagon[i][j].isInside() && keyPressed && key == ENTER) {
        hexagon[i][j].display();
        hexagon[i][j].visible = true;

        //hexagon[i][j].hoovers();
        }
      }
    }
  

    
}
