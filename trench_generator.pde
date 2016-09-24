import controlP5.*;


import peasy.*;
import queasycam.*;


ArrayList<PVector> leftTrenchLine;
ArrayList<PVector> rightTrenchLine;

ArrayList<ArrayList<PVector>> leftTrenchWall;
ArrayList<ArrayList<PVector>> rightTrenchWall;

ArrayList<PVector> trenchFloor;

ArrayList<trenchWoodWall> leftTrenchWoodWalls;
ArrayList<trenchWoodWall> rightTrenchWoodWalls;

PeasyCam camera;
QueasyCam qCamera;

ControlP5 cp5;

int pressed = 0;

int sliderValue = 100;

Slider trenchBentsSlider;

boolean regenerate;

PGraphics pg;

PImage ladderTextureImage;

int numberOfTrenchBents = 10;

void setup() {
  
  numberOfTrenchBents = 30;

  size(800, 800, P3D);
  
  pg = createGraphics(800,800, P3D);
  
  cp5 = new ControlP5(this);
  
  cp5.setAutoDraw(false);
  
  ladderTextureImage = loadImage("ladder.png");
  
  trenchBentsSlider = cp5.addSlider("sliderValue")
     .setPosition(20,20)
     .setRange(1,50)
     .setValue(15)
     .setWidth(200)
     .setHeight(20)
     .setCaptionLabel("TRENCH BENTS");
     
     ;  

  stroke(0, 0, 0);

  camera = new PeasyCam(this, 0, 0, 0, 500);
  

  //qCamera = new QueasyCam(this);
  //qCamera.position = new PVector(0,0,900);

  //camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);

  generate();

  realDraw();

}

void draw() {
  
  if(regenerate){
    
      //numberOfTrenchBents = (int)trenchBentsSliderValue;
    
      generate();
      
      regenerate = false;
  }

  realDraw();
}

void generate() {
  
  
  int trenchOffset = 250;
  int trenchWidth = 130;

  leftTrenchLine = generateTrenchLine("left",numberOfTrenchBents);
  rightTrenchLine = cloneTrenchLine(leftTrenchLine, "right",trenchWidth,numberOfTrenchBents);

  rightTrenchWall = generateTrenchWall(rightTrenchLine);

  leftTrenchWall = generateTrenchWall(leftTrenchLine);

  trenchFloor = generateTrenchFloor(leftTrenchLine, rightTrenchLine, trenchWidth);
  
  leftTrenchWoodWalls = generateTrenchWoodWalls(leftTrenchLine,false,false,"left");
  rightTrenchWoodWalls = generateTrenchWoodWalls(rightTrenchLine,true,true,"right");
}

void keyPressedToGenerate() {

  if (   keyPressed == true && pressed == 0)
    pressed++;

  if (pressed == 1) {
    pressed = 2;

    generate();

    realDraw();
  }

  if (keyPressed == false && pressed == 2) {

    pressed = 0;
  }
}

void realDraw() {
  

  
  //lights();

  background(255, 255, 255);

  scale(0.4);
  translate(-width/2, -height/2);
  rotateX(PI/4);
  /*rotateZ(PI/8);*/

  fill(81, 89, 0);


  drawTrenchLine3D(leftTrenchLine, new PVector(0, 1, 0));
  drawTrenchLine3D(rightTrenchLine, new PVector(0, 1, 0));

  fill(137, 87, 51);

  drawTrenchWalls3D(leftTrenchWall, new PVector(0, 1, 0));
  drawTrenchWalls3D(rightTrenchWall, new PVector(0, 1, 0));

  fill(111, 111, 0);

  drawTrenchFloor3D(trenchFloor, new PVector(0, 1, 0));

  drawTrenchWoodWalls(leftTrenchWoodWalls);
  drawTrenchWoodWalls(rightTrenchWoodWalls);
  
  gui();
}

void gui() {
  hint(DISABLE_DEPTH_TEST);
  camera.beginHUD();
  rect(10,10,400,40);
  cp5.draw();
  camera.endHUD();
  hint(ENABLE_DEPTH_TEST);
}

void sliderValue(float trenchBentsSliderValue) {
  
    if(trenchBentsSliderValue>1){
  
      numberOfTrenchBents = (int)trenchBentsSliderValue;

      regenerate = true;
    }

  //println("a slider event. trenchBents: "+trenchBentsSliderValue);
}