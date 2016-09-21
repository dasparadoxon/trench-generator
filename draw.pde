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

  for (PVector trenchLineBent : toDraw) {



    if (c == 0) {

      prevTrench = trenchLineBent;  

      //ellipse(positionToDraw.x + trenchLineBent.x,positionToDraw.y + trenchLineBent.y,20,20);

      vertex(positionToDraw.x + trenchLineBent.x, positionToDraw.y + trenchLineBent.y);
      
    } else {


      //ellipse(positionToDraw.x + trenchLineBent.x,positionToDraw.y + trenchLineBent.y,20,20);

      vertex(positionToDraw.x + trenchLineBent.x, positionToDraw.y + trenchLineBent.y);

      //line(positionToDraw.x + prevTrench.x,positionToDraw.y + prevTrench.y,positionToDraw.x + trenchLineBent.x,positionToDraw.y + trenchLineBent.y);

      prevTrench = trenchLineBent;
    }

    c++;


    //print(trenchLineBent);
  }


  endShape();
}

void drawTrenchWoodWalls(ArrayList<trenchWoodWall> trenchWoodWallsToDraw){
  
  int i = 0;
  
  for (trenchWoodWall trenchWoodWallToDraw : trenchWoodWallsToDraw) {
    
    i++;
    
    for (trenchWoodWallElement trenchWallElement : trenchWoodWallToDraw.wallElements) {
    
      trenchWoodWallElement firstWallElement = trenchWoodWallToDraw.wallElements.get(0);
      
      //print(i+" : Centerpos: "+ firstWallElement.centerPosition + "\n");
      
      pushMatrix();
      
      fill(203,127,26);
      
      translate(trenchWallElement.centerPosition.x,trenchWallElement.centerPosition.y,trenchWallElement.centerPosition.z);
      
      rotateZ(trenchWallElement.rotation);
      
      box(10,trenchWallElement.lengthOfElement,trenchWoodWallToDraw.heightOfWoodElement);
      
      popMatrix();
    
    }
    
  }
  
}