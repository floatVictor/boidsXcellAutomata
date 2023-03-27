import controlP5.*;
import peasy.*;
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

//global
float warpX = 1;
float warpY = 1;
float warpZ = 1;
CheckBox displayElement, displayFx;

//boids
float align = 1;
float cohesion = 1.2;
float sep = 0.2;

float boidsScale = 1;
int trailSize = 6;

float noiseAmp_b = 10;
float noiseRatioX_b = 0.01;
float noiseRatioY_b = 0.01;
float noiseRatioZ_b = 0.01;

//boidSet
int nbBoids = 1700;
int sizeX = 600;
int sizeY = 400;
int sizeZ = 200;

int minSpeedRef = 1;
int maxSpeedRef = 5;

//ca values
float density = .05;
float cellSize = 2;
int cellOpa = 150;
int nbStates = 10;

int frameReset = 100;
int frameUpdate = 15;

int gridSizeX = int(sizeX * density) + 1;
int gridSizeY = int(sizeY * density) + 1;
int gridSizeZ = int(sizeZ * density) + 1;

float noiseRatioX_ca = 0.1;
float noiseRatioY_ca = 0.1;
float noiseRatioZ_ca = 0.1;

//color
int h = 172;

//UI
int sliderLength = 400;
int sliderHeight = 10;
int checkBoxSize = 10;
boolean visible = true;

//cam
boolean lockCam = true;

PeasyCam cam;
ControlP5 cp5;
PostFX fx;
BoidSet set;
CA ca;

void setup() {
  
  size(1920, 1080, P3D);
  colorMode(HSB);
  background(150);
  
  ca = new CA();
  set = new BoidSet();
  
  //init cam
  cam = new PeasyCam(this, 300);
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(5000);
  cam.setSuppressRollRotationMode();
  
  //UI
  setUI();
  
  //init fx
  fx = new PostFX(this);
}

void draw() {
  
  background(0);
  if (displayFx.getState(1)) background(150);
  translate(-sizeX/2, -sizeY/2, -sizeZ/2);
  if (frameCount % frameReset == 0) ca = new CA();
  if (frameCount % frameUpdate == 0) ca.update();
  if (displayElement.getState(1)) ca.display();
  if (displayElement.getState(0)) set.update();
  //fx
  cam.beginHUD();
  if (displayFx.getState(1)) {
    fx.render()
      .sobel() 
      .compose();
  }
  fx.render()
    //.sobel()  
    .bloom(0, 20, -40)  
    .invert()
    .compose();
  if(!visible) cp5.hide();
  else cp5.show();
  cp5.draw();
  if (displayFx.getState(0)) {
    fx.render()
      .invert()
      .compose();
  }
  cam.endHUD();
}


void keyPressed() {
  if (key == 's') saveFrame("saveFrame/bxcaIA-#####.png");
  if(key == 'c') {
    cam.setActive(!lockCam);
    lockCam = !lockCam;
  }
  if (key == 'h') visible = !visible;
}
