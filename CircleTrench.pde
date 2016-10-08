import java.util.logging.*;

class CircleTrench extends Trench {
  
  private final Logger LOGGER = Logger.getLogger( CircleTrench.class.getName() );
  
  static final String OUTSIDE = "OUTSIDE";
  static final String INSIDE = "INSIDE";
  
  ArrayList<PVector> outerTrenchLine;
  ArrayList<PVector> innerTrenchLine;

  ArrayList<ArrayList<PVector>> outerTrenchWall;
  ArrayList<ArrayList<PVector>> innerTrenchWall;  
  
  ArrayList<CircleTrenchWoodWall> outerTrenchWoodWalls;
  ArrayList<CircleTrenchWoodWall> innerTrenchWoodWalls;  
  
  int amplitudeMultiplier = 160;
  
  Battlefield battlefield;
  

  CircleTrench() {
  }

  void generate() {

    generateTrenchLine();
  }

  void generateTrenchLine() {

    outerTrenchLine = generateTrenchLine(OUTSIDE);
    innerTrenchLine = generateTrenchLine(INSIDE);

    outerTrenchWall = generateTrenchWall(outerTrenchLine);
    innerTrenchWall = generateTrenchWall(innerTrenchLine);

    trenchFloor = generateTrenchFloor(outerTrenchLine);
    
    //outerTrenchWoodWalls = generateTrenchWoodWalls(outerTrenchLine, true, true, OUTSIDE);
    //innerTrenchWoodWalls = generateTrenchWoodWalls(innerTrenchLine, false, false, INSIDE);
    
  }  

  /*************************************************************************************
   *
   *************************************************************************************/
  ArrayList<PVector> generateTrenchLine(String alignment) {
    
    if(alignment == INSIDE)
      amplitudeMultiplier -= trenchWidth;

    ArrayList<PVector> circleTrenchPoints = new ArrayList<PVector>();

    int yOffset = (int)battlefield.dimensions.y / 4;
    int xOffset = (int)battlefield.dimensions.y / 2;

    int xStepSize = 20;

    int zOffset = 100;

    int circleSize = 2;

    if (alignment == OUTSIDE) {

      circleTrenchPoints.add(new PVector(0, 0, zOffset));
      circleTrenchPoints.add(new PVector(battlefield.dimensions.x, 0, zOffset));
      circleTrenchPoints.add(new PVector(battlefield.dimensions.x, battlefield.dimensions.y, zOffset));
      circleTrenchPoints.add(new PVector(0, battlefield.dimensions.y, zOffset));
      circleTrenchPoints.add(new PVector(0, 0, zOffset));
    }

    for (int sinusCounter = 0; sinusCounter < 200; sinusCounter = sinusCounter + xStepSize) {

      float sinusValue = sin(radians(sinusCounter)) * amplitudeMultiplier;
      float cosValue = cos(radians(sinusCounter))*amplitudeMultiplier;

      int yPos = yOffset - (int)sinusValue;

      PVector tempCirclePoint = new PVector(xOffset + cosValue * circleSize, yPos * circleSize, 100);

      circleTrenchPoints.add(tempCirclePoint);

      //print("tempCirclePoint:"+tempCirclePoint+"\n");
    }

    for (int sinusCounter = 160; sinusCounter < 380; sinusCounter = sinusCounter + xStepSize) {

      float sinusValue = sin(radians(sinusCounter)) * amplitudeMultiplier;
      float cosValue = cos(radians(sinusCounter))*amplitudeMultiplier;

      int yPos = yOffset - (int)sinusValue;

      PVector tempCirclePoint = new PVector(xOffset + cosValue * circleSize, yPos * circleSize, zOffset);

      circleTrenchPoints.add(tempCirclePoint);

      //print("tempCirclePoint:"+tempCirclePoint+"\n");
    }     

    return circleTrenchPoints;
  }



  /*************************************************************************************
   *
   *************************************************************************************/
  ArrayList<ArrayList<PVector>> generateTrenchWall(ArrayList<PVector> trenchLine) {

    int wall_height = 100;

    ArrayList<ArrayList<PVector>> tempTrenchWall;

    tempTrenchWall = new ArrayList<ArrayList<PVector>>();

    for (int trenchBent = 0; trenchBent < trenchLine.size()-1; trenchBent++) {

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

      //if(trenchBent > 4)
      tempTrenchWall.add(tempWall);
      
      //print(tempTrenchWall + "\n");
    }

    return tempTrenchWall;
  }

  /*************************************************************************************
   *
   *************************************************************************************/
  ArrayList<PVector> generateTrenchFloor(ArrayList<PVector> trenchLine) {

    ArrayList<PVector> tempTrenchFloor;
    
    int zValueToShift = 500;

    tempTrenchFloor = new ArrayList<PVector>();

    for (int trenchBent=4; trenchBent < trenchLine.size()-1; trenchBent++) {

      PVector zShift = trenchLine.get(trenchBent);

      tempTrenchFloor.add(new PVector(zShift.x, zShift.y, zShift.z - zValueToShift));
      
     
    }

    PVector lastshift = trenchLine.get(0);

    tempTrenchFloor.add(new PVector(lastshift.x, lastshift.y, lastshift.z -zValueToShift));  

    return tempTrenchFloor;
  }

  /*************************************************************************************
   *
   *************************************************************************************/
  ArrayList<CircleTrenchWoodWall> generateCicleTrenchWoodWalls(ArrayList<PVector> trenchLine, boolean hasLadder, boolean hasSandbags, String alignment) {

    ArrayList<CircleTrenchWoodWall> tempTrenchWoodWalls;

    tempTrenchWoodWalls = new ArrayList<CircleTrenchWoodWall>();

    int c = 0;
    
    int trenchPointsStartIndex = 5;
    
    if(alignment == INSIDE) 
      trenchPointsStartIndex = 0;

    for (int trenchBent=trenchPointsStartIndex; trenchBent<trenchLine.size()-1 ; trenchBent++) {

      CircleTrenchWoodWall tempTrenchWoodWall;

      boolean placeLadder = false;

      if ((c%3) == 0)placeLadder = true;
        else placeLadder = false;

      if (hasLadder == false)placeLadder = false;

      tempTrenchWoodWall = new CircleTrenchWoodWall(trenchLine.get(trenchBent), trenchLine.get(trenchBent+1), placeLadder, alignment, hasSandbags);

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