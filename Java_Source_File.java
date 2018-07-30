int cols, rows;
int scl = 20;

int w = 2500;
int h = 1600;

float flying = 0;
  
float[][] terrain; 

void setup() { 
  
  size(600, 600, P3D);
  colorMode(RGB, 255);
  
  cols = w / scl;
  rows = h/ scl;
  
  terrain = new float[cols][rows];
}

void draw() {

  flying -= 0.065;
  
  float yoff = flying;
  for (int y = 0; y < rows-1; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {   
        terrain[x][y] = map(noise(xoff,yoff), 0, 1, -150, 150);
        xoff += 0.15;
    }
    yoff += 0.15;
  }
  
  background(0);
  
  stroke(255);
  
  translate(width/2, height/2 - 200);
  rotateX(PI/2);
 
 if (frameCount % 5 == 0) {
   fill(random(255), random(255), random(255), 255);
 }
 
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {    
    beginShape(TRIANGLE_STRIP);       
    for (int x = 0; x < cols; x++) {       
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }  
  
  //New Shape Testing
  //noFill();

  translate(0, 0, -350);
  for (int y = 0; y < rows-1; y++) {    
    beginShape(TRIANGLE_STRIP);       
    for (int x = 0; x < cols; x++) {       
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }

}