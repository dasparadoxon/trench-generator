
import peasy.*;
import queasycam.*;

ArrayList<PVector> leftTrenchLine;
ArrayList<PVector> rightTrenchLine;

ArrayList<ArrayList<PVector>> leftTrenchWall;
ArrayList<ArrayList<PVector>> rightTrenchWall;

ArrayList<PVector> trenchFloor;

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

  leftTrenchLine = generateTrenchLine("left");
  rightTrenchLine = cloneTrenchLine(leftTrenchLine, "right");

  rightTrenchWall = generateTrenchWall(rightTrenchLine);

  leftTrenchWall = generateTrenchWall(leftTrenchLine);

  trenchFloor = generateTrenchFloor(leftTrenchLine, rightTrenchLine);

  realDraw();

  //rotateY(PI/8);
}

void draw() {

realDraw();

}

void keyPressedToGenerate(){
  
    if (   keyPressed == true && pressed == 0)
    pressed++;

  if (pressed == 1) {
    pressed = 2;

    leftTrenchLine = generateTrenchLine("left");
    rightTrenchLine = cloneTrenchLine(leftTrenchLine, "right");

    rightTrenchWall = generateTrenchWall(rightTrenchLine);

    leftTrenchWall = generateTrenchWall(leftTrenchLine);

    trenchFloor = generateTrenchFloor(leftTrenchLine, rightTrenchLine);

    realDraw();
  }

  if (keyPressed == false && pressed == 2) {

    pressed = 0;
  }
  
}

void realDraw() {

  background(255, 255, 255);

  scale(0.1);
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
  
  translate(0,0);
  
  sphere(20);
}

void drawTrenchFloor3D(ArrayList<PVector> floorToDraw, PVector positionToDraw) {

  beginShape();

  for (PVector trenchWallPoint : floorToDraw) {



    //sprint("Adding Vertex :" + trenchWallPoint +"\n");

    vertex(positionToDraw.x + trenchWallPoint.x, positionToDraw.y + trenchWallPoint.y, positionToDraw.z + trenchWallPoint.z);



    //print(trenchLineBent);
  }

  endShape();
}

void drawTrenchWalls3D(ArrayList<ArrayList<PVector>> wallsToDraw, PVector positionToDraw) {



  int c = 0;

  PVector prevTrench = new PVector();

  for (ArrayList<PVector> trenchWall : wallsToDraw) {

    beginShape();

    for (PVector trenchWallPoint : trenchWall) {

      vertex(positionToDraw.x + trenchWallPoint.x, positionToDraw.y + trenchWallPoint.y, positionToDraw.z + trenchWallPoint.z);
    }

    endShape();

    //print(trenchLineBent);
  }
}


void drawTrenchLine3D(ArrayList<PVector> toDraw, PVector positionToDraw) {

  beginShape();

  int c = 0;

  PVector prevTrench = new PVector();

  for (PVector trenchLineBent : toDraw) {



    if (c == 0) {

      prevTrench = trenchLineBent;  

      //ellipse(positionToDraw.x + trenchLineBent.x,positionToDraw.y + trenchLineBent.y,20,20);

      vertex(positionToDraw.x + trenchLineBent.x, positionToDraw.y + trenchLineBent.y);
    } else {


      //ellipse(positionToDraw.x + trenchLineBent.x,positionToDraw.y + trenchLineBent.y,20,20);

      vertex(positionToDraw.x + trenchLineBent.x, positionToDraw.y + trenchLineBent.y);

      //line(positionToDraw.x + prevTrench.x,positionToDraw.y + prevTrench.y,positionToDraw.x + trenchLineBent.x,positionToDraw.y + trenchLineBent.y);

      prevTrench = trenchLineBent;
    }

    c++;


    //print(trenchLineBent);
  }


  endShape();
}

ArrayList<PVector> generateTrenchLine(String allignment) {

  int numberOfTrenchBents = 10;
  int progressionInUnits = 1;

  ArrayList<PVector> tempTrenchLine;

  tempTrenchLine = new ArrayList<PVector>(numberOfTrenchBents);

  for (int trenchBent=0; trenchBent < numberOfTrenchBents; trenchBent++) {

    int yStep = (int)random(35, 120);

    PVector newTrenchBent = new PVector(width/2, progressionInUnits, 0);

    progressionInUnits += yStep;

    if (progressionInUnits >= 800) {
      progressionInUnits = 800;
    }

    tempTrenchLine.add(newTrenchBent);
  }

  if (tempTrenchLine.get(numberOfTrenchBents-1).y < width)
    tempTrenchLine.get(numberOfTrenchBents-1).y = width;

  for (int trenchBent=0; trenchBent<numberOfTrenchBents; trenchBent++) {

    int xStep = (int)random(width/10, width/5);

    if ((int)random(0, 1)==1)xStep = -xStep;

    tempTrenchLine.get(trenchBent).x = xStep;

    progressionInUnits += xStep;

  }  


  if (allignment == "left") {

    PVector leftDownCorner = new PVector(0, height, 0);

    tempTrenchLine.add(leftDownCorner);

    PVector leftUpCorner = new PVector(0, 0, 0);

    tempTrenchLine.add(leftUpCorner);

    tempTrenchLine.add(tempTrenchLine.get(0));
  }  

  if (allignment == "right") {

    PVector rightDownCorner = new PVector(width, height, 0);

    tempTrenchLine.add(rightDownCorner);

    PVector rightUpCorner = new PVector(width, 0, 0);

    tempTrenchLine.add(rightUpCorner);

    tempTrenchLine.add(tempTrenchLine.get(0));
  }   

  return tempTrenchLine;
}



ArrayList<PVector> cloneTrenchLine(ArrayList<PVector> trenchLineToClone, String allignment) {

  int numberOfTrenchBents = 10;
  int progressionInUnits = 1;

  ArrayList<PVector> tempTrenchLine;

  tempTrenchLine = new ArrayList<PVector>(numberOfTrenchBents);

  for (int trenchBent=0; trenchBent<numberOfTrenchBents; trenchBent++) {

    tempTrenchLine.add(trenchLineToClone.get(trenchBent));

    int xStep = (int)random(width/10, width/5);

    if ((int)random(0, 1)==1)xStep = -xStep;

    tempTrenchLine.get(trenchBent).x = xStep;

    progressionInUnits += xStep;

  }  


  if (allignment == "left") {

    PVector leftDownCorner = new PVector(0, height, 0);

    tempTrenchLine.add(leftDownCorner);

    PVector leftUpCorner = new PVector(0, 0, 0);

    tempTrenchLine.add(leftUpCorner);

    tempTrenchLine.add(tempTrenchLine.get(0));
  }  

  if (allignment == "right") {

    PVector rightDownCorner = new PVector(width, height, 0);

    tempTrenchLine.add(rightDownCorner);

    PVector rightUpCorner = new PVector(width, 0, 0);

    tempTrenchLine.add(rightUpCorner);

    tempTrenchLine.add(tempTrenchLine.get(0));
  }   

  return tempTrenchLine;
}

ArrayList<ArrayList<PVector>> generateTrenchWall(ArrayList<PVector> trenchLine) {

  int wall_height = 100;

  ArrayList<ArrayList<PVector>> tempTrenchWall;

  tempTrenchWall = new ArrayList<ArrayList<PVector>>();

  for (int trenchBent=0; trenchBent<trenchLine.size()-1; trenchBent++) {

    ArrayList<PVector> tempWall = new ArrayList<PVector>();

    PVector start = trenchLine.get(trenchBent);

    tempWall.add(start);

    PVector down = new PVector(start.x, start.y, start.z - wall_height);

    tempWall.add(down);

    PVector oneStepUp = trenchLine.get(trenchBent + 1);

    PVector oneStep = new PVector(oneStepUp.x, oneStepUp.y, oneStepUp.z - wall_height);

    tempWall.add(oneStep);

    tempWall.add(oneStepUp);

    tempWall.add(start);

    tempTrenchWall.add(tempWall);
  }

  return tempTrenchWall;
}

ArrayList<PVector> generateTrenchFloor(ArrayList<PVector> left, ArrayList<PVector> right) {

  ArrayList<PVector> tempTrenchFloor;

  tempTrenchFloor = new ArrayList<PVector>();

  for (int trenchBent=0; trenchBent<left.size()-1 -2; trenchBent++) {

    print("Putting "+left.get(trenchBent)+" into TrenchFloor \n");

    PVector shift = left.get(trenchBent);

    tempTrenchFloor.add(new PVector(shift.x, shift.y, shift.z -100));

}

  for (int trenchBent=right.size()-1 -3; trenchBent > -1; trenchBent--) {

    PVector shift = left.get(trenchBent);

    tempTrenchFloor.add(new PVector(shift.x+100, shift.y, shift.z -100));
  } 

  PVector lastshift = left.get(0);

  tempTrenchFloor.add(new PVector(lastshift.x, lastshift.y, lastshift.z -100));  


  return tempTrenchFloor;
}