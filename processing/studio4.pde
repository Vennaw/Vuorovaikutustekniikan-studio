Hexagon[][] hexagon;   

int rad = 60; //size of the hexagon
int hexcountx, hexcounty;
float zoom = 1;
float xo;
float yo;
ArrayList artists;

int buttonValue = 1;
boolean isOpen;
int myColorBackground = color(0,0,0);


void setup() {
  size(1200, 800);
  xo = width/2;
  yo = height/2;
  smooth();

  background(255);
  frameRate(50); //Specifies the number of frames to be displayed every second.
  hexcountx = parseInt(width/(rad));
  hexcounty = parseInt(width/(rad));
  resetCanvas();
}

void resetCanvas(){
  hexagon = new Hexagon [hexcountx][hexcounty];
  artists = new ArrayList();
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

void addNewArtist(int index, String str){
  if(index == null){
    artists.add(new Artist(str));
  }else{
    artists.add(index, new Artist(str));
  }
}

Artist getArtists(){
  return artists;
}

void addRelatedArtists(int i, int j, boolean oddColumn, boolean oddRow, String[] array){
  int a = i;
  int b = j-2;
  int c = i;
  int d = j-1;
  int e = i;
  int f = j+1;
  int g = i;
  int h = j+2;

  if(!oddColumn && !oddRow){   
    int o = i-1;
    int p = j+1;
    int q = i-1;
    int r = j-1;
  }else if(oddColumn && !oddRow){
    int o = i+1;
    int p = j+1;
    int q = i+1;
    int r = j-1;
  }else if(oddColumn && oddRow){
    int o = i+1;
    int p = j+1;
    int q = i+1;
    int r = j-1;
  }else if(!oddColumn && oddRow){
    int o = i-1;
    int p = j+1;
    int q = i-1;
    int r = j-1;
  }

   for(int k = 0; k < array.length; k++){
    boolean next = false;
        for (int m = 0; m < hexcountx; m ++ ) {     
          for (int n = 0; n < hexcounty; n ++ ) {
            if(hexagon[m][n].artistID == array[k].id){
              next = true;
              break;
            }
          }
        }
    if(next){
      continue;
    }else{
      if(array[k].images.length == 0){
        string imgurl = "default.png";
      }else{
        string imgurl = array[k].images[0].url;
      }
      if(hexagon[a][b] != null && !hexagon[a][b].visible){
        addNewArtist(null, array[k]);
        hexagon[a][b].setArtist(array[k].id, imgurl);
        hexagon[a][b].visible = true;

      }else if(hexagon[c][d] != null && !hexagon[c][d].visible){
        addNewArtist(null, array[k]);
        hexagon[c][d].setArtist(array[k].id, imgurl);
        hexagon[c][d].visible = true;
          
      }else if(hexagon[e][f] != null && !hexagon[e][f].visible){
        addNewArtist(null, array[k]);
        hexagon[e][f].setArtist(array[k].id, imgurl);
        hexagon[e][f].visible = true;
          
      }else if(hexagon[g][h] != null && !hexagon[g][h].visible){
        addNewArtist(null, array[k]);
        hexagon[g][h].setArtist(array[k].id, imgurl);
        hexagon[g][h].visible = true;
          
      }else if(hexagon[o][p] != null && !hexagon[o][p].visible){
        addNewArtist(null, array[k]);
        hexagon[o][p].setArtist(array[k].id, imgurl);
        hexagon[o][p].visible = true;
          
      }else if(hexagon[q][r] != null && !hexagon[q][r].visible){
        addNewArtist(null, array[k]);
        hexagon[q][r].setArtist(array[k].id, imgurl);
        hexagon[q][r].visible = true;
          
      }
      else{
        break;
      }
    } 
  }
      

  //TODO: Check if hexagon is inside the canvas (otherwise undefined error...)
}


void draw() {
  background(255);

  float cursorX = (mouseX-xo)/zoom + xo;
  float cursorY = (mouseY-yo)/zoom + yo;

  translate(xo,yo);
  scale(zoom);

  for (int i = 0; i < hexcountx; i ++ ) {     
    for (int j = 0; j < hexcounty; j ++ ) {
      if (hexagon[i][j].isInside(cursorX, cursorY) && hexagon[i][j].visible){
        hexagon[i][j].hoover = true;
        for (int k = 0; k < artists.size(); k++){
          if (artists.get(k).data.id == hexagon[i][j].artistID)
            hexagon[i][j].artistName = artists.get(k).data.name;
        }
      } else {
        hexagon[i][j].hoover = false;
      }if(hexagon[i][j].visible){
        pushMatrix();
        translate(-xo,-yo);
        hexagon[i][j].display();
        popMatrix();
      }
    }
  }
  



}

void setSeedArtist(){
  int hexX = parseInt(hexcountx/5.75);
  int hexY = parseInt(hexcounty/2);
  
  if(artists.get(0).data.images.length != 0){
    hexagon[hexX][hexY].setArtist(artists.get(0).data.id, artists.get(0).data.images[0].url, artists.g); 
  }else{
    hexagon[hexX][hexY].setArtist(artists.get(0).data.id, "default.png", artists.g); 
  }
  hexagon[hexX][hexY].visible = true;
  
  if (hexX % 2 == 0 && hexY % 2 == 0) {
    getRelatedArtists(hexX, hexY, false, false, hexagon[hexX][hexY].artistID);
  } else if(hexX%2 == 0 && hexY % 2 != 0){
    getRelatedArtists(hexX, hexY, false, true, hexagon[hexX][hexY].artistID);
  } else if(hexX%2 != 0 && hexY % 2 == 0){
    getRelatedArtists(hexX, hexY, true, false, hexagon[hexX][hexY].artistID);
  } else if(hexX%2 != 0 && hexY % 2 != 0){
    getRelatedArtists(hexX, hexY, true, true, hexagon[hexX][hexY].artistID);
  }
}


void mouseClicked() {
  float cursorX = (mouseX-xo)/zoom + xo;
  float cursorY = (mouseY-yo)/zoom + yo;
  for (int i = 0; i < hexcountx; i ++ ) {     
    for (int j = 0; j < hexcounty; j ++ ) {
      if (hexagon[i][j].isInside(cursorX, cursorY) && hexagon[i][j].visible){
        if (i % 2 == 0 && j % 2 == 0) {
          getRelatedArtists(i, j, false, false, hexagon[i][j].artistID);
        } else if(i%2 == 0 && j % 2 != 0){
          getRelatedArtists(i, j, false, true, hexagon[i][j].artistID);
        } else if(i%2 != 0 && j % 2 == 0){
          getRelatedArtists(i, j, true, false, hexagon[i][j].artistID);
        } else if(i%2 != 0 && j % 2 != 0){
          getRelatedArtists(i, j, true, true, hexagon[i][j].artistID);
        }
      }
    }
  }
}


// zooming keys
  void keyPressed() {
    if (key == 'i'){
        zoom += 0.13;
      } else if (key == 'o') {
        zoom -= 0.13;
      } else if (key == 'r') {
        zoom = 1;
        xo = width/2;
        yo = height/2;
    }
  }
