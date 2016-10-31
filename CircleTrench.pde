import java.util.logging.*;

class CircleTrench extends Trench {

  int xStepSize = 42;

  boolean outsideOnly = false;

  private final Logger LOGGER = Logger.getLogger( CircleTrench.class.getName() );

  static final String OUTSIDE = "OUTSIDE";
  static final String INSIDE = "INSIDE";

  ArrayList<PVector> outerTrenchLine;
  ArrayList<PVector> innerTrenchLine;

  ArrayList<ArrayList<PVector>> outerTrenchWall;
  ArrayList<ArrayList<PVector>> innerTrenchWall;  

  ArrayList<CircleTrenchWoodWall> outerTrenchWoodWalls;
  ArrayList<CircleTrenchWoodWall> innerTrenchWoodWalls;  

  int amplitudeMultiplier = 460;

  Battlefield battlefield;


  CircleTrench() {

    setLogger(LOGGER, Trench.class.getName(), Level.FINEST);


    LOGGER.fine("Circle Trench Constructor");
  }

  void setAmplitudeMultiplier(int amplitudeMultiplierToSet) {

    amplitudeMultiplier = amplitudeMultiplierToSet;
  }

  void setCircleSegmentNumber(int segmentNumberToSet) {

    xStepSize = segmentNumberToSet;
  }

  void generate() throws Exception {

    LOGGER.info("Generating Circle Trench");

    generateTrenchLine();
  }

  void setBattlefield(Battlefield battlefieldToSet) {

    LOGGER.fine("Setting Battlefield : " + battlefieldToSet.dimensions.toString());

    battlefield =  battlefieldToSet;
  }  

  void generateTrenchLine() throws Exception {

    LOGGER.fine("Generating Circle Trench Line");

    outerTrenchLine = generateTrenchLine(OUTSIDE);

    outerTrenchWall = generateTrenchWall(outerTrenchLine,OUTSIDE);

    trenchFloor = generateTrenchFloor(outerTrenchLine);

    outerTrenchWoodWalls = generateCircleTrenchWoodWalls(outerTrenchLine, true, true, OUTSIDE);

    if (!outsideOnly) {

      innerTrenchLine = generateTrenchLine(INSIDE);
      innerTrenchWall = generateTrenchWall(innerTrenchLine,INSIDE);
      innerTrenchWoodWalls = generateCircleTrenchWoodWalls(innerTrenchLine, false, false, INSIDE);
    }
  }  

  /*************************************************************************************
   *
   *************************************************************************************/
  ArrayList<PVector> generateTrenchLine(String alignment) throws Exception {

    LOGGER.fine("Generating Circle Trench Line with alignment : "+alignment);

    LOGGER.finest("Circle Trench Alignment is : "+alignment);

    if (alignment == INSIDE) {

      amplitudeMultiplier -= trenchWidth;
    }

    ArrayList<PVector> circleTrenchPoints = new ArrayList<PVector>();

    if (battlefield == null)
      throw new Exception("Battlefield in Circle Trench not set !");

    LOGGER.finest("Battlefield in CircleTrench : " + battlefield.dimensions.toString());

    int yOffset = (int)battlefield.dimensions.y / 4;
    int xOffset = (int)battlefield.dimensions.y / 2;



    int zOffset = 100;

    int circleSize = 2;

    LOGGER.finest("xOffset : "+xOffset+" | yOffset : "+ yOffset + " | zOffset : " + zOffset + " | Circle Size : "+circleSize);

    if (alignment == "OUTSIDE") {

      LOGGER.finest("Adding outside area to the trench points of the outer circle Trench");

      circleTrenchPoints.add(new PVector(0, 0, zOffset));
      circleTrenchPoints.add(new PVector(battlefield.dimensions.x, 0, zOffset));
      circleTrenchPoints.add(new PVector(battlefield.dimensions.x, battlefield.dimensions.y, zOffset));
      circleTrenchPoints.add(new PVector(0, battlefield.dimensions.y, zOffset));
      circleTrenchPoints.add(new PVector(0, 0, zOffset));
    }

    int firstHalfTurnAngle = 180;

    for (int sinusCounter = 0; sinusCounter < firstHalfTurnAngle; sinusCounter = sinusCounter + xStepSize) {

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
  ArrayList<ArrayList<PVector>> generateTrenchWall(ArrayList<PVector> trenchLine, String alignment) {

    LOGGER.fine("Generation Circle Trench Wall.");
    
    int indexOfBentToIgnoreToSeperateOuterWallsFromTrenchWalls = 4;

    int wall_height = 100;

    ArrayList<ArrayList<PVector>> tempTrenchWall;

    tempTrenchWall = new ArrayList<ArrayList<PVector>>();

    for (int trenchBent = 0; trenchBent < trenchLine.size()-1; trenchBent++) {

     if (trenchBent != indexOfBentToIgnoreToSeperateOuterWallsFromTrenchWalls || alignment == INSIDE) {

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
    }
    return tempTrenchWall;
  }

  /*************************************************************************************
   *
   *************************************************************************************/
  ArrayList<PVector> generateTrenchFloor(ArrayList<PVector> trenchLine) {

    LOGGER.fine("Generating Trench Floor...");

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
  ArrayList<CircleTrenchWoodWall> generateCircleTrenchWoodWalls(ArrayList<PVector> trenchLine, boolean hasLadder, boolean hasSandbags, String alignment) {

    LOGGER.fine("Generating Circle Trench Wood Wall");

    ArrayList<CircleTrenchWoodWall> tempTrenchWoodWalls;

    tempTrenchWoodWalls = new ArrayList<CircleTrenchWoodWall>();

    int c = 0;

    int trenchPointsStartIndex = 5;

    if (alignment == INSIDE) 
      trenchPointsStartIndex = 0;

    for (int trenchBent=trenchPointsStartIndex; trenchBent<trenchLine.size()-1; trenchBent++) {

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