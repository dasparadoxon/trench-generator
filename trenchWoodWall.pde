

public class TrenchWoodWall {
  
  //private static final Logger log = Logger.getLogger( TrenchWoodWall.class.getName() );
  

  static final String OUTSIDE = "OUTSIDE";
  static final String INSIDE = "INSIDE"; 

  boolean hasLadder = false;
  boolean hasSandbags = false;

  Ladder theLadder;
  
  ArrayList<Pole> poles;

  int numberOfWoodsOnWall = 10;
  int heightOfWall = 100;
  int heightOfWoodElement = 14;

  PVector topRightPosition = new PVector(0, 0, 0);

  float centerRotation = 0f;

  PVector originVector;
  PVector secondVector;

  ArrayList<TrenchWoodWallElement> wallElements = new ArrayList<TrenchWoodWallElement>();

  ArrayList<SandBag> sandBags = new ArrayList<SandBag>();
  
  TrenchToXML trenchToXML = null;

  TrenchWoodWall(PVector origin, PVector second, boolean addLadder, String alignment, boolean addSandbags) {
    
 
    
    poles = new ArrayList<Pole>();

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

      if (alignment == OUTSIDE)
        tempWallElement.centerPosition.z =  (heightOfWoodElement * elementNr) + (( (heightOfWall  - (numberOfElements * heightOfWoodElement))/numberOfElements)/2);

      if (alignment == INSIDE)
        tempWallElement.centerPosition.z =  (heightOfWoodElement * elementNr) + (( (heightOfWall  - (numberOfElements * heightOfWoodElement))/numberOfElements)/2);        

      tempWallElement.lengthOfElement = lengthOfElement;

      wallElements.add(tempWallElement);
      
      // export to XML
      
      trenchToXML.addWoodWallElement(tempWallElement.centerPosition,tempWallElement.rotation,tempWallElement.lengthOfElement);
      
      if(elementNr == 0){
        
          Pole newPole = new Pole();
          newPole.centerPosition = tempWallElement.centerPosition ;
          newPole.lengthOfElement = 100.0;
          newPole.rotation = tempWallElement.rotation;
          
          poles.add(newPole);
        
      }
    }

    if (hasLadder) {

      PVector normalVector = relNormForLater.copy();

      normalVector.rotate(HALF_PI);

      theLadder = new Ladder();

      theLadder.rotation = -angleInDegrees;

      theLadder.ladderHeight = -100;

      int allignment_distance = 4;
      int allignment_distance_bottom = 35;

      if (alignment=="left") {

        allignment_distance = 35;
        allignment_distance_bottom = 4;
      }



      theLadder.topLeft = centerPos.copy();

      theLadder.topLeft.z += 20;

      theLadder.topLeft = PVector.add(theLadder.topLeft, PVector.mult(relNormForLater, 15));

      theLadder.topLeft = PVector.add(theLadder.topLeft, PVector.mult(normalVector, allignment_distance));



      theLadder.topRight = centerPos.copy();

      theLadder.topRight.z += 20;

      theLadder.topRight = PVector.add(theLadder.topRight, PVector.mult(relNormForLater, -15));

      theLadder.topRight = PVector.add(theLadder.topRight, PVector.mult(normalVector, allignment_distance));



      theLadder.bottomLeft = centerPos.copy();

      theLadder.bottomLeft = PVector.add(theLadder.bottomLeft, PVector.mult(relNormForLater, 15));

      theLadder.bottomLeft = PVector.add(theLadder.bottomLeft, new PVector(0, 0, theLadder.ladderHeight));

      theLadder.bottomLeft = PVector.add(theLadder.bottomLeft, PVector.mult(normalVector, allignment_distance_bottom));


      theLadder.bottomRight = centerPos.copy();


      theLadder.bottomRight = PVector.add(theLadder.bottomRight, PVector.mult(relNormForLater, -15));

      theLadder.bottomRight = PVector.add(theLadder.bottomRight, new PVector(0, 0, theLadder.ladderHeight));

      theLadder.bottomRight = PVector.add(theLadder.bottomRight, PVector.mult(normalVector, allignment_distance_bottom));
      
      trenchToXML.addLadder(theLadder);
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

      tempSandBag.centerPosition = PVector.add(tempSandBag.centerPosition, PVector.mult(normalVector, -22));

      tempSandBag.rotation = rotateTo;

      if (!hasLadder)
        sandBags.add(tempSandBag);

      if (hasLadder && (i != (numberOfBags/3)))
        sandBags.add(tempSandBag);
    }

    for (SandBag sandbagToXML : sandBags) {

      trenchToXML.addSandbag(sandbagToXML.centerPosition.x, sandbagToXML.centerPosition.y, sandbagToXML.centerPosition.z, sandbagToXML.rotation);
      
    }
  }
}