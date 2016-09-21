class trenchWoodWallElement {
  
    float rotation;
    PVector centerPosition;
    float lengthOfElement;
}


class trenchWoodWall {
  
  int numberOfWoodsOnWall = 10;
  int heightOfWall = 100;
  
  PVector topRightPosition = new PVector(0,0,0);
  
  float centerRotation = 0f;
  
  ArrayList<trenchWoodWallElement> wallElements = new ArrayList<trenchWoodWallElement>();
  
  trenchWoodWall(PVector origin,PVector second){
    
    
    
    PVector lOrigin = origin.copy();
    PVector lSecond = second.copy();
    
    // calculate angle
    
    PVector rel = PVector.sub(lSecond,lOrigin);
    
    //float angleInDegrees = atan(rel.y / rel.x) * 180 / PI;
    
    float angleInDegrees = degrees(PVector.angleBetween(lOrigin,lSecond));
    
    float lengthOfElement = PVector.sub(origin,second).mag();
    
    PVector relNorm = rel.normalize();
    
    PVector centerPos = lOrigin.add(relNorm.mult(lengthOfElement/2));
    
    trenchWoodWallElement tempWallElement = new trenchWoodWallElement();
    
    tempWallElement.rotation = angleInDegrees;
    tempWallElement.centerPosition = centerPos;
    tempWallElement.lengthOfElement = lengthOfElement;
    
    wallElements.add(tempWallElement);
    
    print("Creating new Trench Wood Wall between "+origin+" and "+second+" with angle : "+angleInDegrees+" and length :"+lengthOfElement+"\n");
    
  }
  
  
}