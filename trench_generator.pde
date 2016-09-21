
import peasy.*;
import queasycam.*;


ArrayList<PVector> leftTrenchLine;
ArrayList<PVector> rightTrenchLine;

ArrayList<ArrayList<PVector>> leftTrenchWall;
ArrayList<ArrayList<PVector>> rightTrenchWall;

ArrayList<PVector> trenchFloor;

ArrayList<trenchWoodWall> leftTrenchWoodWalls;

PeasyCam camera;
QueasyCam qCamera;

int pressed = 0;

void setup() {

  size(800, 800, P3D);

  stroke(0, 0, 0);

  camera = new PeasyCam(this, 0, 0, 0, 200);

  //qCamera = new QueasyCam(this);
  //qCamera.position = new PVector(0,0,900);

  //camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);

  generate();

  realDraw();

}

void draw() {

  realDraw();
}

void generate() {

  leftTrenchLine = generateTrenchLine("left");
  rightTrenchLine = cloneTrenchLine(leftTrenchLine, "right");

  rightTrenchWall = generateTrenchWall(rightTrenchLine);

  leftTrenchWall = generateTrenchWall(leftTrenchLine);

  trenchFloor = generateTrenchFloor(leftTrenchLine, rightTrenchLine);
  
  leftTrenchWoodWalls = generateTrenchWoodWalls(leftTrenchLine);
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

  scale(0.2);
  translate(-width/2, -height/2);
  rotateX(PI/4);
  /*rotateZ(PI/8);*/

  fill(51, 137, 58);


  drawTrenchLine3D(leftTrenchLine, new PVector(00, 1, 0));
  drawTrenchLine3D(rightTrenchLine, new PVector(100, 1, 0));

  fill(137, 87, 51);

  drawTrenchWalls3D(leftTrenchWall, new PVector(00, 1, 0));
  drawTrenchWalls3D(rightTrenchWall, new PVector(100, 1, 0));

  fill(51, 51, 0);

  drawTrenchFloor3D(trenchFloor, new PVector(0, 1, 0));

  translate(0, 0);

  sphere(20);
  
  drawTrenchWoodWalls(leftTrenchWoodWalls);
}