class trenchWoodWallElement {
  
    float rotation;
    PVector centerPosition;
    float lengthOfElement;
}


class trenchWoodWall {
  
  int numberOfWoodsOnWall = 10;
  int heightOfWall = 100;
  int heightOfWoodElement = 14;
  
  PVector topRightPosition = new PVector(0,0,0);
  
  float centerRotation = 0f;
  
  PVector originVector;
  PVector secondVector;
  
  ArrayList<trenchWoodWallElement> wallElements = new ArrayList<trenchWoodWallElement>();
  
  trenchWoodWall(PVector origin,PVector second){
    
    originVector = origin.copy();
    secondVector = second.copy();
    
    PVector lOrigin = origin.copy();
    PVector lSecond = second.copy();
    
    // calculate angle
    
    PVector rel = PVector.sub(second,origin);

    float lengthOfElement = PVector.sub(origin,second).mag();
    
    PVector relNorm = rel.normalize().copy();
    
    PVector centerPos = lOrigin.add(relNorm.mult(lengthOfElement/2));
    
    //centerPos = origin.copy();
    
    float angleInDegrees = degrees(PVector.angleBetween(centerPos,origin));
    float angleInDegrees2 = atan(rel.y / rel.x) * 180 / PI;
    float angleInDegrees3 = degrees(PVector.angleBetween(second,origin));
    
    float a = degrees(PVector.angleBetween(relNorm,new PVector(0.0,0.0,0.0)));
    
    
    
    
    //centerPos = origin.copy();
    
    PVector defaultAngle = new PVector(0,1,0);
    
    float angleInDegrees4 = PVector.angleBetween(relNorm,defaultAngle);
    
    print("A4:"+degrees(angleInDegrees4)+" | Rel/Normalized : ("+rel+"/"+relNorm.normalize()+") Angle:"+a+"\n");
    
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
    
    //print("Creating new Trench Wood Wall between "+origin+" and "+second+" with angle : "+tempWallElement.rotation+") and length :"+lengthOfElement+"\n");
    //print("Centerpos: "+ centerPos + "\n");
    
  }
  
  
}