class Trench {

  ArrayList<PVector> leftOrOuterTrenchLine;
  ArrayList<PVector> rightOrInnerTrenchLine;

  ArrayList<ArrayList<PVector>> leftTrenchWall;
  ArrayList<ArrayList<PVector>> rightTrenchWall;

  ArrayList<PVector> trenchFloor;

  ArrayList<TrenchWoodWall> leftTrenchWoodWalls;
  ArrayList<TrenchWoodWall> rightTrenchWoodWalls;

  ArrayList<RowOfBarbedWire> barbedWireRows;
  
  
  
  Trench(){
    
  }
  
  void generateTrench(){
   
    leftOrOuterTrenchLine = generateTrenchCirle("OUTER",false,null);
    
  }

  void generateStraightTrench() {

    int trenchOffset = 250;
    int trenchWidth = 130;

    leftOrOuterTrenchLine = generateTrenchLine("left", numberOfTrenchBents);
    rightOrInnerTrenchLine = cloneTrenchLine(leftOrOuterTrenchLine, "right", trenchWidth, numberOfTrenchBents);

    rightTrenchWall = generateTrenchWall(rightOrInnerTrenchLine);

    leftTrenchWall = generateTrenchWall(leftOrOuterTrenchLine);

    trenchFloor = generateTrenchFloor(leftOrOuterTrenchLine, rightOrInnerTrenchLine, trenchWidth);

    leftTrenchWoodWalls = generateTrenchWoodWalls(leftOrOuterTrenchLine, false, false, "left");
    rightTrenchWoodWalls = generateTrenchWoodWalls(rightOrInnerTrenchLine, true, true, "right");

    barbedWireRows = generateBarbedWireRows(leftOrOuterTrenchLine);
    
    
  }  
  
  ArrayList<PVector> generateTrenchCirle(String alignment,boolean clone,ArrayList<PVector> toClone) {
    
      ArrayList<PVector> circleTrenchPoints = new ArrayList<PVector>();
    
      int yOffset = (int)battlefield.dimensions.y / 4;
      int xOffset = (int)battlefield.dimensions.y / 2;
      
      int xStepSize = 20;
      
      int zOffset = 100;
      
      int amplitudeMultiplier = 100;
      
      int circleSize = 2;
      
      
      
      for(int sinusCounter = 0; sinusCounter < 200;sinusCounter = sinusCounter + xStepSize){
        
            float sinusValue = sin(radians(sinusCounter)) * amplitudeMultiplier;
            float cosValue = cos(radians(sinusCounter))*amplitudeMultiplier;
            
            int yPos = yOffset - (int)sinusValue;
            
            PVector tempCirclePoint = new PVector(xOffset + cosValue * circleSize,yPos * circleSize,100);
            
            circleTrenchPoints.add(tempCirclePoint);
            
            print("tempCirclePoint:"+tempCirclePoint+"\n");
        
      }
      
      for(int sinusCounter = 160; sinusCounter < 360;sinusCounter = sinusCounter + xStepSize){
        
            float sinusValue = sin(radians(sinusCounter)) * amplitudeMultiplier;
            float cosValue = cos(radians(sinusCounter))*amplitudeMultiplier;
            
            int yPos = yOffset - (int)sinusValue;
            
            PVector tempCirclePoint = new PVector(xOffset + cosValue * circleSize,yPos * circleSize,zOffset);
            
            circleTrenchPoints.add(tempCirclePoint);
            
            print("tempCirclePoint:"+tempCirclePoint+"\n");
      }     
      
      if(alignment == "OUTER"){
        
         circleTrenchPoints.add(new PVector(0,0,zOffset));
         circleTrenchPoints.add(new PVector(battlefield.dimensions.x,0,zOffset));
         circleTrenchPoints.add(new PVector(battlefield.dimensions.x,battlefield.dimensions.y,zOffset));
         circleTrenchPoints.add(new PVector(0,battlefield.dimensions.y,zOffset));
      }
      
      return circleTrenchPoints;
    
  }

  /*************************************************************************************
   *
   *************************************************************************************/
  ArrayList<PVector> generateTrenchLine(String allignment, int numberOfTrenchBents) {

    int progressionInUnits = 1;

    ArrayList<PVector> tempTrenchLine;

    tempTrenchLine = new ArrayList<PVector>(numberOfTrenchBents);

    for (int trenchBent=0; trenchBent < numberOfTrenchBents; trenchBent++) {

      int yStep = (int)random((battlefield.dimensions.x/numberOfTrenchBents), (battlefield.dimensions.x/numberOfTrenchBents));

      PVector newTrenchBent = new PVector(battlefield.dimensions.x/2, progressionInUnits, 0);

      progressionInUnits += yStep;

      if (progressionInUnits >= battlefield.dimensions.x) {
        progressionInUnits = (int)battlefield.dimensions.x;
      }

      tempTrenchLine.add(newTrenchBent);
    }

    if (numberOfTrenchBents<2)numberOfTrenchBents = 1;

    if (tempTrenchLine.get(numberOfTrenchBents-1).y < battlefield.dimensions.x)
      tempTrenchLine.get(numberOfTrenchBents-1).y = battlefield.dimensions.x;

    for (int trenchBent=0; trenchBent<numberOfTrenchBents; trenchBent++) {

      int xStep = (int)random(battlefield.dimensions.x/10, battlefield.dimensions.x/5);

      if ((int)random(0, 1)==1)xStep = -xStep;

      tempTrenchLine.get(trenchBent).x = xStep;

      progressionInUnits += xStep;
    }  

    if (allignment == "left") {

      PVector leftDownCorner = new PVector(0, battlefield.dimensions.y, 0);

      tempTrenchLine.add(leftDownCorner);

      PVector leftUpCorner = new PVector(0, 0, 0);

      tempTrenchLine.add(leftUpCorner);

      tempTrenchLine.add(tempTrenchLine.get(0));
    }  

    if (allignment == "right") {

      PVector rightDownCorner = new PVector(battlefield.dimensions.x, battlefield.dimensions.y, 0);

      tempTrenchLine.add(rightDownCorner);

      PVector rightUpCorner = new PVector(battlefield.dimensions.x, 0, 0);

      tempTrenchLine.add(rightUpCorner);

      tempTrenchLine.add(tempTrenchLine.get(0));
    }   

    return tempTrenchLine;
  }

  /*************************************************************************************
   *
   *************************************************************************************/
  ArrayList<PVector> cloneTrenchLine(ArrayList<PVector> trenchLineToClone, String allignment, int offsetX, int numberOfTrenchBents) {

    int progressionInUnits = 1;

    ArrayList<PVector> tempTrenchLine;

    tempTrenchLine = new ArrayList<PVector>(numberOfTrenchBents);

    for (int trenchBent=0; trenchBent<numberOfTrenchBents; trenchBent++) {

      PVector vectorToClone = trenchLineToClone.get(trenchBent).copy();

      vectorToClone.x += offsetX;

      tempTrenchLine.add(vectorToClone);
    }  

    if (allignment == "left") {

      PVector leftDownCorner = new PVector(0, battlefield.dimensions.y, 0);

      tempTrenchLine.add(leftDownCorner);

      PVector leftUpCorner = new PVector(0, 0, 0);

      tempTrenchLine.add(leftUpCorner);

      tempTrenchLine.add(tempTrenchLine.get(0));
    }  

    if (allignment == "right") {

      PVector rightDownCorner = new PVector( battlefield.dimensions.x, battlefield.dimensions.y, 0);

      tempTrenchLine.add(rightDownCorner);

      PVector rightUpCorner = new PVector( battlefield.dimensions.x, 0, 0);

      tempTrenchLine.add(rightUpCorner);

      tempTrenchLine.add(tempTrenchLine.get(0));
    }   

    return tempTrenchLine;
  }

  /*************************************************************************************
   *
   *************************************************************************************/
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

  /*************************************************************************************
   *
   *************************************************************************************/
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

  /*************************************************************************************
   *
   *************************************************************************************/
  ArrayList<TrenchWoodWall> generateTrenchWoodWalls(ArrayList<PVector> trenchLine, boolean hasLadder, boolean hasSandbags, String allignment) {

    ArrayList<TrenchWoodWall> tempTrenchWoodWalls;

    tempTrenchWoodWalls = new ArrayList<TrenchWoodWall>();

    int c = 0;

    for (int trenchBent=0; trenchBent<trenchLine.size()-1 -3; trenchBent++) {

      TrenchWoodWall tempTrenchWoodWall;

      boolean placeLadder = false;

      if ((c%3) == 0)placeLadder = true;
      else placeLadder = false;

      if (hasLadder == false)placeLadder = false;

      tempTrenchWoodWall = new TrenchWoodWall(trenchLine.get(trenchBent), trenchLine.get(trenchBent+1), placeLadder, allignment, hasSandbags);

      tempTrenchWoodWalls.add(tempTrenchWoodWall);

      c++;
    }

    return tempTrenchWoodWalls;
  }

  /*************************************************************************************
   *
   *************************************************************************************/
  ArrayList<RowOfBarbedWire> generateBarbedWireRows(ArrayList<PVector> leftTrenchLine) {

    ArrayList<RowOfBarbedWire> tempRowOfBarbedWire;

    tempRowOfBarbedWire = new ArrayList<RowOfBarbedWire>();

    int numberOfRows = (int)random(battlefield.dimensions.x/120, battlefield.dimensions.x/120 + battlefield.dimensions.x/45);

    for (int i=0; i<numberOfRows; i++) {

      RowOfBarbedWire tempWire = new RowOfBarbedWire();

      tempWire.centerPosition = new PVector(battlefield.dimensions.x / 4 + random(200, 350), 100 + random(1, battlefield.dimensions.y-100), 16);      

      tempRowOfBarbedWire.add(tempWire);
    }

    return tempRowOfBarbedWire;
  }
}