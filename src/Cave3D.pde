int r;
int h;
int rows;
int cols;
float scl;
float sclRad;
float curRad;
float terrain[][];
float flying = 0;
float xoff, yoff, zoff;

void setTerrain() {
  zoff = flying;
  for (int y=0; y<rows-1; y++) {
    for (int x=0; x<cols+1; x++) {
      xoff = (float)Math.sin(x*sclRad);
      yoff = (float)Math.cos(x*sclRad);
      terrain[x][y] = map(noise(xoff+100, yoff+100, zoff), 0, 1, -500, 500);
    }
    zoff += 0.15;
  }
  flying -= 0.01;
}

void setup() {
  size(displayWidth, displayHeight, P3D);
  surface.setTitle("Terrain3D");
  surface.setLocation(0, 0);

  r = displayWidth/2 ;
  h = displayHeight + 2000;;
  cols = 40;
  sclRad = TWO_PI / cols;
  scl = sclRad * r;
  rows = Math.round(h / scl);

  terrain = new float[cols+1][rows];
}

void draw() {
  background(0);
  stroke(20);
  //pointLight(255, 255, 255, width/2, height/2, 1000);

  translate(width/2, height/2);
  rotateX(PI/2);
  translate(0, -h/2 - 400);

  setTerrain();

  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    fill(Math.round(100 * y/(rows-1)));
    for (int x=0; x < cols+1; x++) {
      curRad = x*sclRad;
      vertex(Math.round(r*Math.sin(curRad) + terrain[x][y]*Math.cos(curRad)), y*scl, Math.round(r*Math.cos(curRad) + terrain[x][y]*Math.sin(curRad)));
      vertex(Math.round(r*Math.sin(curRad) + terrain[x][y+1]*Math.cos(curRad)), (y+1)*scl, Math.round(r*Math.cos(curRad) + terrain[x][y+1]*Math.sin(curRad)));
    }
    endShape();
  }
}
