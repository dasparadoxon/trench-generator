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
  
  int sizeOfBents = toDraw.size()-1;

  for (PVector trenchLineBent : toDraw) {

    if (c == 0) {

      prevTrench = trenchLineBent;  

      vertex(positionToDraw.x + trenchLineBent.x, positionToDraw.y + trenchLineBent.y,0);
      
    } else {


      vertex(positionToDraw.x + trenchLineBent.x, positionToDraw.y + trenchLineBent.y,0);

      prevTrench = trenchLineBent;
    }

    c++;

  }


  endShape();
}

void drawTrenchWoodWalls(ArrayList<trenchWoodWall> trenchWoodWallsToDraw){
  
  int i = 0;
  
  
  
  for (trenchWoodWall trenchWoodWallToDraw : trenchWoodWallsToDraw) {
    
    i++;
    
   
    
    
    for (trenchWoodWallElement trenchWallElement : trenchWoodWallToDraw.wallElements) {
    
      
      
      //print(i+" : Centerpos: "+ firstWallElement.centerPosition + "\n");
      
      pushMatrix();
      
      fill(203,127,26);
      
      translate(trenchWallElement.centerPosition.x,trenchWallElement.centerPosition.y,trenchWallElement.centerPosition.z);
      
      rotateZ(trenchWallElement.rotation);
      
      box(10,trenchWallElement.lengthOfElement,trenchWoodWallToDraw.heightOfWoodElement);
      
      popMatrix();
      
     
    
    }
    
    // draw poles
    
    trenchWoodWallElement firstWallElement = trenchWoodWallToDraw.wallElements.get(0);
    
    pushMatrix();
    
    fill(0,0,0);
    
    translate(trenchWoodWallToDraw.originVector.x,trenchWoodWallToDraw.originVector.y,trenchWoodWallToDraw.originVector.z - 40);
    
    box(15,15,100);
    
    popMatrix();
    

    
  }
  
  trenchWoodWall lastWall = trenchWoodWallsToDraw.get(trenchWoodWallsToDraw.size()-1);
  
    pushMatrix();
    
    fill(0,0,0);
    
    translate(lastWall.secondVector.x,lastWall.secondVector.y,lastWall.secondVector.z - 40);
    
    box(15,15,100);
    
    popMatrix();  
  
}