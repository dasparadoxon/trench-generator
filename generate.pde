

ArrayList<PVector> generateTrenchLine(String allignment,int numberOfTrenchBents) {
  
  print(numberOfTrenchBents);


  int progressionInUnits = 1;

  ArrayList<PVector> tempTrenchLine;

  tempTrenchLine = new ArrayList<PVector>(numberOfTrenchBents);

  for (int trenchBent=0; trenchBent < numberOfTrenchBents; trenchBent++) {

    int yStep = (int)random((height/numberOfTrenchBents), (height/numberOfTrenchBents));

    PVector newTrenchBent = new PVector(width/2, progressionInUnits, 0);

    progressionInUnits += yStep;

    if (progressionInUnits >= 800) {
      progressionInUnits = 800;
    }

    tempTrenchLine.add(newTrenchBent);
  }
  
  if(numberOfTrenchBents<2)numberOfTrenchBents = 1;

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

/***
*   Clones a Trench Line 
*///

ArrayList<PVector> cloneTrenchLine(ArrayList<PVector> trenchLineToClone, String allignment,int offsetX,int numberOfTrenchBents) {

  //int numberOfTrenchBents = 10;
  int progressionInUnits = 1;

  ArrayList<PVector> tempTrenchLine;

  tempTrenchLine = new ArrayList<PVector>(numberOfTrenchBents);

  for (int trenchBent=0; trenchBent<numberOfTrenchBents; trenchBent++) {
    
    PVector vectorToClone = trenchLineToClone.get(trenchBent).copy();
    
    vectorToClone.x += offsetX;

    tempTrenchLine.add(vectorToClone);

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

ArrayList<PVector> generateTrenchFloor(ArrayList<PVector> left, ArrayList<PVector> right, int offsetX) {

  ArrayList<PVector> tempTrenchFloor;

  tempTrenchFloor = new ArrayList<PVector>();

  for (int trenchBent=0; trenchBent<left.size()-1 -2; trenchBent++) {

    //print("Putting "+left.get(trenchBent)+" into TrenchFloor \n");

    PVector shift = left.get(trenchBent);

    tempTrenchFloor.add(new PVector(shift.x, shift.y, shift.z - 100));
  }

  for (int trenchBent=right.size()-1 -3; trenchBent > -1; trenchBent--) {

    PVector shift = left.get(trenchBent);

    tempTrenchFloor.add(new PVector(shift.x+ offsetX, shift.y, shift.z -100));
  } 

  PVector lastshift = left.get(0);

  tempTrenchFloor.add(new PVector(lastshift.x, lastshift.y, lastshift.z -100));  


  return tempTrenchFloor;
}

ArrayList<trenchWoodWall> generateTrenchWoodWalls(ArrayList<PVector> trenchLine){
  
  ArrayList<trenchWoodWall> tempTrenchWoodWalls;
  
  tempTrenchWoodWalls = new ArrayList<trenchWoodWall>();
  
  for (int trenchBent=0; trenchBent<trenchLine.size()-1 -3; trenchBent++) {
    
    trenchWoodWall tempTrenchWoodWall;
  
    tempTrenchWoodWall = new trenchWoodWall(trenchLine.get(trenchBent),trenchLine.get(trenchBent+1));
    
    tempTrenchWoodWalls.add(tempTrenchWoodWall);
  
  }
  
  return tempTrenchWoodWalls;
}