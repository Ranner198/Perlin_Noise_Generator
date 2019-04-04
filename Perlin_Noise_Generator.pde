import java.io.*;
import java.util.Scanner;

int cols, rows;
int scl = 20;

int selection = 0, maxNum = 2;

int w = 2500;
int h = 1600;

float flying = 0;
  
float[][] terrain; 

int rotation_value = 0;

int offset = 350;

color oldColor, newColor;
float lerpCounter;

void setup() { 
  
  //frameRate(10);
  
  fullScreen(P3D);
  
  //size(600, 600, P3D);
  colorMode(RGB, 255);
  
  cols = w / scl;
  rows = h/ scl;
  
  terrain = new float[cols][rows];
  
  camera(0,0,0,0,0,0,0,0,0);
  
  oldColor = color(random(255), random(255), random(255));
  newColor = color(random(255), random(255), random(255));
}

void draw() {
  
  //Camera Spin Effect  
  beginCamera();
  camera();
  //Pretty neat
  //rotateY(radians(rotation_value));
  endCamera();
  
  if (rotation_value > 359)
    rotation_value = 0;
    
  rotation_value++;
  
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
  
  switch (selection) {
    case 0:
       translate(width/2, height/2 - 200);
       rotateX(PI/2);
       rotateY(radians(0));
       rotateZ(radians(0));
    break;
    case 1:
       translate(width/2, height/2 - 200);
       rotateX(radians(90));
       rotateY(radians(rotation_value));
       //rotateZ(0);
    break;
    case 2:
       translate(width/2, height/2 - 200);
       rotateX(radians(90));
       rotateZ(radians(rotation_value));
       //rotateY(radians(90));
    break; 
  }

 if(lerpCounter >= 1) 
 {
   lerpCounter = 0;
   oldColor = newColor;
   newColor = color(random(255), random(255), random(255));
 }
 else
   lerpCounter += 0.05;
   
  print(lerpCounter);
   
 fill(lerpColor(oldColor, newColor, lerpCounter));
 
  translate(-w/2, -h/2, offset);
  for (int y = 0; y < rows-1; y++) {    
    beginShape(TRIANGLE_STRIP);       
    for (int x = 0; x < cols; x++) {       
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }  
  
  translate(0, 0, -offset-350);
  for (int y = 0; y < rows-1; y++) {    
    beginShape(TRIANGLE_STRIP);       
    for (int x = 0; x < cols; x++) {       
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }  
}

void keyPressed() {
  if (selection > maxNum)
    selection = 1;
  else
    selection++;
}
