class trenchWoodWallElement {
  
    float rotation;
    PVector centerPosition;
    float lengthOfElement;
}

class ladder {
  
  PVector topLeft;
  PVector topRight;
  PVector bottomLeft;
  PVector bottomRight;  
  
  float w,h;
  float rotation;
  
  int leaderHeight = 10;
  
  int ladderWidth = 30;
  int ladderHeight = 70;  
  
}

class sandBag {
  
  public static final int lengthOfBag = 31;
  
  int adaptedLength;
  
  PVector centerPosition;
  
  float rotation;
  
}


class trenchWoodWall {
  
  boolean hasLadder = false;
  boolean hasSandbags = false;
  
  ladder theLadder;
  
  int numberOfWoodsOnWall = 10;
  int heightOfWall = 100;
  int heightOfWoodElement = 14;
  
  PVector topRightPosition = new PVector(0,0,0);
  
  float centerRotation = 0f;
  
  PVector originVector;
  PVector secondVector;
  
  ArrayList<trenchWoodWallElement> wallElements = new ArrayList<trenchWoodWallElement>();
  
  ArrayList<sandBag> sandBags = new ArrayList<sandBag>();
  
  trenchWoodWall(PVector origin,PVector second,boolean addLadder,String allignment,boolean addSandbags){
    
    hasLadder = addLadder;
    hasSandbags = addSandbags;
    
    originVector = origin.copy();
    secondVector = second.copy();
    
    PVector lOrigin = origin.copy();
    PVector lSecond = second.copy();
    
    // calculate angle
    
    PVector rel = PVector.sub(second,origin);

    float lengthOfElement = PVector.sub(origin,second).mag();
    
    PVector relNorm = rel.normalize().copy();
    
    PVector relNormForLater = relNorm.copy();
    
    PVector centerPos = lOrigin.add(relNorm.mult(lengthOfElement/2));
    
    //centerPos = origin.copy();
    
    float angleInDegrees = degrees(PVector.angleBetween(centerPos,origin));
    float angleInDegrees2 = atan(rel.y / rel.x) * 180 / PI;
    float angleInDegrees3 = degrees(PVector.angleBetween(second,origin));
    
    float a = degrees(PVector.angleBetween(relNorm,new PVector(0.0,0.0,0.0)));
    
    
    
    
    //centerPos = origin.copy();
    
    PVector defaultAngle = new PVector(0,1,0);
    
    float angleInDegrees4 = PVector.angleBetween(relNorm,defaultAngle);
    
    //print("A4:"+degrees(angleInDegrees4)+" | Rel/Normalized : ("+rel+"/"+relNorm.normalize()+") Angle:"+a+"\n");
    
    if(rel.x < 0)angleInDegrees4 = -angleInDegrees4;
    
    int numberOfElements = heightOfWall / heightOfWoodElement ;
    
    for(int elementNr = 0; elementNr < numberOfElements; elementNr++){
    
      
        trenchWoodWallElement tempWallElement = new trenchWoodWallElement();
        
        tempWallElement.rotation = -angleInDegrees4;
        tempWallElement.centerPosition = centerPos.copy();
        tempWallElement.centerPosition.z = - (heightOfWoodElement * elementNr) + (( (heightOfWall  - (numberOfElements * heightOfWoodElement))/numberOfElements)/2);
        tempWallElement.lengthOfElement = lengthOfElement;
        
        wallElements.add(tempWallElement);
      
    }
    
    if(hasLadder){
      
      PVector normalVector = relNormForLater.copy();
      
      normalVector.rotate(HALF_PI);
      
      theLadder = new ladder();
      
      theLadder.rotation = -angleInDegrees4;
      
      theLadder.ladderHeight = -100;
      
      int allignment_distance = 4;
      int allignment_distance_bottom = 35;
      
      if(allignment=="left"){
        
           allignment_distance = 35;
           allignment_distance_bottom = 4;
      }
        
      
      
      theLadder.topLeft = centerPos.copy();
      
      theLadder.topLeft.z += 20;
      
      theLadder.topLeft = PVector.add(theLadder.topLeft,PVector.mult(relNormForLater,15));
      
      theLadder.topLeft = PVector.add(theLadder.topLeft,PVector.mult(normalVector,allignment_distance));

    
      
      theLadder.topRight = centerPos.copy();
      
      theLadder.topRight.z += 20;
      
      theLadder.topRight = PVector.add(theLadder.topRight,PVector.mult(relNormForLater,-15));
      
      theLadder.topRight = PVector.add(theLadder.topRight,PVector.mult(normalVector,allignment_distance));
 
      
      
      theLadder.bottomLeft = centerPos.copy();
      
     // theLadder.bottomLeft.z += 20;
      
      theLadder.bottomLeft = PVector.add(theLadder.bottomLeft,PVector.mult(relNormForLater,15));
      
      theLadder.bottomLeft = PVector.add(theLadder.bottomLeft,new PVector(0,0,theLadder.ladderHeight));
      
      theLadder.bottomLeft = PVector.add(theLadder.bottomLeft,PVector.mult(normalVector,allignment_distance_bottom));
      
      
      theLadder.bottomRight = centerPos.copy();
      
      //theLadder.bottomLeft.z += 20;
      
      theLadder.bottomRight = PVector.add(theLadder.bottomRight,PVector.mult(relNormForLater,-15));
      
      theLadder.bottomRight = PVector.add(theLadder.bottomRight,new PVector(0,0,theLadder.ladderHeight));
      
      theLadder.bottomRight = PVector.add(theLadder.bottomRight,PVector.mult(normalVector,allignment_distance_bottom));

      
    }
    
    //print("Creating new Trench Wood Wall between "+origin+" and "+second+" with angle : "+tempWallElement.rotation+") and length :"+lengthOfElement+"\n");
    //print("Centerpos: "+ centerPos + "\n");
    
    //if(!hasLadder){
      
        if(hasSandbags){
        
        PVector normalVector = relNormForLater.copy();
        
        normalVector.rotate(HALF_PI);
        
        createSandBags(lengthOfElement,centerPos,relNormForLater,-angleInDegrees4,normalVector,allignment,hasLadder);
      //}
    }
    
  }
  
  void createSandBags(float lengthOfElement,PVector centerPosition, PVector surfaceEdgeDirVec, float rotateTo, PVector normalVector, String alignment,boolean hasLadder ){
    
      print("NUmber of bags :"+(lengthOfElement / sandBag.lengthOfBag)+"\n");
    
      int numberOfBags = (int)floor(lengthOfElement / sandBag.lengthOfBag); 
      
      if((numberOfBags % 2)==0) 
        numberOfBags--;
      
      int positionShift = 35;
      
      int alignmentShift = 18;
      
      sandBag tempSandBag;
      
      for(int i=0;i<numberOfBags;i++){
        
        
    
        tempSandBag = new sandBag();
        
        tempSandBag.centerPosition = centerPosition;
        
        tempSandBag.centerPosition = PVector.add(tempSandBag.centerPosition,PVector.mult(surfaceEdgeDirVec,(i * positionShift)-(positionShift*(numberOfBags/2))));
        
        if(alignment=="right"){
          alignmentShift = -alignmentShift;
          normalVector = new PVector(-normalVector.x,-normalVector.y,-normalVector.z);
        }
        alignmentShift = -alignmentShift;
        normalVector = new PVector(-normalVector.x,-normalVector.y,-normalVector.z);
        
        tempSandBag.centerPosition = PVector.add(tempSandBag.centerPosition,PVector.mult(normalVector,-22));
        
        tempSandBag.rotation = rotateTo;
        
        //tempSandBag.adaptedLength = 
        
        if(!hasLadder)
          sandBags.add(tempSandBag);
    
        if(hasLadder && (i != (numberOfBags/2)))
          sandBags.add(tempSandBag);
      }
    
  }
  
  
}