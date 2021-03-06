import java.util.logging.*;

class CircleTrenchWoodWall {
  
  private final Logger LOGGER = Logger.getLogger( CircleTrenchWoodWall.class.getName() );
  
  static final String OUTSIDE = "OUTSIDE";
  static final String INSIDE = "INSIDE"; 

  boolean hasLadder = false;
  boolean hasSandbags = false;

  Ladder theLadder;

  int numberOfWoodsOnWall = 10;
  int heightOfWall = 100;
  int heightOfWoodElement = 14;

  PVector topRightPosition = new PVector(0, 0, 0);

  float centerRotation = 0f;

  PVector originVector;
  PVector secondVector;

  ArrayList<TrenchWoodWallElement> wallElements = new ArrayList<TrenchWoodWallElement>();

  ArrayList<SandBag> sandBags = new ArrayList<SandBag>();

  CircleTrenchWoodWall(PVector origin, PVector second, boolean addLadder, String alignment, boolean addSandbags) {
    
    setLogger(LOGGER,Trench.class.getName(),Level.INFO);
    
    LOGGER.fine("CircleTrenchWoodWall Constructor");

    hasLadder = addLadder;
    hasSandbags = addSandbags;

    originVector = origin.copy();
    secondVector = second.copy();

    PVector lOrigin = origin.copy();
    PVector lSecond = second.copy();

    // calculate angle

    PVector rel = PVector.sub(second, origin);

    float lengthOfElement = PVector.sub(origin, second).mag();

    PVector relNorm = rel.normalize().copy();

    PVector relNormForLater = relNorm.copy();

    PVector centerPos = lOrigin.add(relNorm.mult(lengthOfElement/2));

    float a = degrees(PVector.angleBetween(relNorm, new PVector(0.0, 0.0, 0.0)));

    PVector defaultAngle = new PVector(0, 1, 0);

    float angleInDegrees = PVector.angleBetween(relNorm, defaultAngle);

    if (rel.x < 0)angleInDegrees = -angleInDegrees;

    int numberOfElements = heightOfWall / heightOfWoodElement ;

    for (int elementNr = 0; elementNr < numberOfElements; elementNr++) {

      TrenchWoodWallElement tempWallElement = new TrenchWoodWallElement();

      tempWallElement.rotation = -angleInDegrees;
      tempWallElement.centerPosition = centerPos.copy();
      tempWallElement.centerPosition.z = - (heightOfWoodElement * elementNr) + (( (heightOfWall  - (numberOfElements * heightOfWoodElement))/numberOfElements)/2);
      
      if(alignment == OUTSIDE)
        tempWallElement.centerPosition.z =  (heightOfWoodElement * elementNr) + (( (heightOfWall  - (numberOfElements * heightOfWoodElement))/numberOfElements)/2);
        
      if(alignment == INSIDE)
        tempWallElement.centerPosition.z =  (heightOfWoodElement * elementNr) + (( (heightOfWall  - (numberOfElements * heightOfWoodElement))/numberOfElements)/2);        
      
      tempWallElement.lengthOfElement = lengthOfElement;

      wallElements.add(tempWallElement);
    }

    if (hasLadder) {

      PVector normalVector = relNormForLater.copy();

      normalVector.rotate(HALF_PI);

      theLadder = new Ladder();

      theLadder.rotation = -angleInDegrees;

      theLadder.ladderHeight = -100;

      int alignment_distance = 35;
      int alignment_distance_bottom = 4;

      if (alignment=="left") {

        alignment_distance = 25;
        alignment_distance_bottom = 4;
      }
      
      int circleCorrectionOffset = 40;

      //centerPos = PVector.add(centerPos,PVector.mult(relNormForLater,20));

      theLadder.topLeft = centerPos.copy();

      theLadder.topLeft.z += 20;

      theLadder.topLeft = PVector.add(theLadder.topLeft, PVector.mult(relNormForLater, 15));

      theLadder.topLeft = PVector.add(theLadder.topLeft, PVector.mult(normalVector, alignment_distance - circleCorrectionOffset));



      theLadder.topRight = centerPos.copy();

      theLadder.topRight.z += 20;

      theLadder.topRight = PVector.add(theLadder.topRight, PVector.mult(relNormForLater, -15));

      theLadder.topRight = PVector.add(theLadder.topRight, PVector.mult(normalVector, alignment_distance - circleCorrectionOffset ));



      theLadder.bottomLeft = centerPos.copy();

      theLadder.bottomLeft = PVector.add(theLadder.bottomLeft, PVector.mult(relNormForLater, 15));

      theLadder.bottomLeft = PVector.add(theLadder.bottomLeft, new PVector(0, 0, theLadder.ladderHeight));

      theLadder.bottomLeft = PVector.add(theLadder.bottomLeft, PVector.mult(normalVector, alignment_distance_bottom - circleCorrectionOffset));


      theLadder.bottomRight = centerPos.copy();


      theLadder.bottomRight = PVector.add(theLadder.bottomRight, PVector.mult(relNormForLater, -15));

      theLadder.bottomRight = PVector.add(theLadder.bottomRight, new PVector(0, 0, theLadder.ladderHeight));

      theLadder.bottomRight = PVector.add(theLadder.bottomRight, PVector.mult(normalVector, alignment_distance_bottom - circleCorrectionOffset));
    }


    if (hasSandbags) {

      PVector normalVector = relNormForLater.copy();

      normalVector.rotate(HALF_PI);

      createSandBags(lengthOfElement, centerPos, relNormForLater, -angleInDegrees, normalVector, alignment, hasLadder);
    }
  }

  void createSandBags(float lengthOfElement, PVector centerPosition, PVector surfaceEdgeDirVec, float rotateTo, PVector normalVector, String alignment, boolean hasLadder ) {

    //print("NUmber of bags :"+(lengthOfElement / SandBag.lengthOfBag)+"\n");

    int numberOfBags = (int)floor(lengthOfElement / SandBag.lengthOfBag); 

    //if ((numberOfBags % 2)==0) 
    //  numberOfBags--;

    int positionShift = 35;

    int alignmentShift = 18;

    SandBag tempSandBag;

    for (int i=0; i<numberOfBags; i++) {

      tempSandBag = new SandBag();

      tempSandBag.centerPosition = centerPosition;

      tempSandBag.centerPosition = PVector.add(tempSandBag.centerPosition, PVector.mult(surfaceEdgeDirVec, (i * positionShift)-(positionShift*(numberOfBags/2))));

      if (alignment=="right") {
        alignmentShift = -alignmentShift;
        normalVector = new PVector(-normalVector.x, -normalVector.y, -normalVector.z);
      }
      alignmentShift = -alignmentShift;
      normalVector = new PVector(-normalVector.x, -normalVector.y, -normalVector.z);
      
      if (alignment=="OUTSIDE") {
        alignmentShift = -alignmentShift;
        normalVector = new PVector(-normalVector.x, -normalVector.y, -normalVector.z);
      }
    

      tempSandBag.centerPosition = PVector.add(tempSandBag.centerPosition, PVector.mult(normalVector, -22));
      
      if (alignment=="OUTSIDE") {
        
        tempSandBag.centerPosition = PVector.add(tempSandBag.centerPosition, PVector.mult(normalVector, 42));
      }      

      tempSandBag.rotation = rotateTo;

      if (!hasLadder)
        sandBags.add(tempSandBag);

       if (alignment!="OUTSIDE")
       if (hasLadder && (i != (numberOfBags/2)))
        sandBags.add(tempSandBag);
    }
  }
}