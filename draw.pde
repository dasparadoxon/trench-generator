void drawTrenchFloor3D(ArrayList<PVector> floorToDraw, PVector positionToDraw) {

  beginShape();

  for (PVector trenchWallPoint : floorToDraw) {


    vertex(positionToDraw.x + trenchWallPoint.x, positionToDraw.y + trenchWallPoint.y, positionToDraw.z + trenchWallPoint.z);
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

      vertex(positionToDraw.x + trenchLineBent.x, positionToDraw.y + trenchLineBent.y, 0);
    } else {


      vertex(positionToDraw.x + trenchLineBent.x, positionToDraw.y + trenchLineBent.y, 0);

      prevTrench = trenchLineBent;
    }

    c++;
  }


  endShape();
}

void drawTrenchWoodWalls(ArrayList<trenchWoodWall> trenchWoodWallsToDraw) {

  int i = 0;



  for (trenchWoodWall trenchWoodWallToDraw : trenchWoodWallsToDraw) {

    i++;

    for (trenchWoodWallElement trenchWallElement : trenchWoodWallToDraw.wallElements) {



      //print(i+" : Centerpos: "+ firstWallElement.centerPosition + "\n");

      pushMatrix();

      fill(203, 127, 26);

      translate(trenchWallElement.centerPosition.x, trenchWallElement.centerPosition.y, trenchWallElement.centerPosition.z);

      rotateZ(trenchWallElement.rotation);

      box(10, trenchWallElement.lengthOfElement, trenchWoodWallToDraw.heightOfWoodElement);

      popMatrix();
    }

    // draw poles

    trenchWoodWallElement firstWallElement = trenchWoodWallToDraw.wallElements.get(0);

    pushMatrix();

    fill(0, 0, 0);

    translate(trenchWoodWallToDraw.originVector.x, trenchWoodWallToDraw.originVector.y, trenchWoodWallToDraw.originVector.z - 40);

    box(15, 15, 100);

    popMatrix();

    if (trenchWoodWallToDraw.hasLadder)
      drawLadder(trenchWoodWallToDraw.theLadder);
  }

  trenchWoodWall lastWall = trenchWoodWallsToDraw.get(trenchWoodWallsToDraw.size()-1);

  pushMatrix();

  fill(0, 0, 0);

  translate(lastWall.secondVector.x, lastWall.secondVector.y, lastWall.secondVector.z - 40);

  box(15, 15, 100);

  popMatrix();

  if (lastWall.hasLadder)
    drawLadder(lastWall.theLadder);
}

void drawLadderWithSpheres(ladder ladderToDraw) {
  
   int zOffset = -80;

   pushMatrix();
   
   translate(ladderToDraw.topLeft.x, ladderToDraw.topLeft.y, ladderToDraw.topLeft.z + zOffset);
   
   popMatrix();
   
   pushMatrix();
   
   fill(124, 124, 210);  
   
   translate(ladderToDraw.topLeft.x, ladderToDraw.topLeft.y, ladderToDraw.topLeft.z + zOffset);
   
   sphere(3);
   
   popMatrix();
   
   pushMatrix();
   
   translate(ladderToDraw.topRight.x, ladderToDraw.topRight.y, ladderToDraw.topRight.z + zOffset);
   
   sphere(3);
   
   popMatrix();
   
   pushMatrix();
   
   fill(124, 124, 210);  
   
   translate(ladderToDraw.bottomLeft.x, ladderToDraw.bottomLeft.y, ladderToDraw.bottomLeft.z + zOffset);
   
   sphere(3);
   
   popMatrix();
   
   pushMatrix();
   
   translate(ladderToDraw.bottomRight.x, ladderToDraw.bottomRight.y, ladderToDraw.bottomRight.z + zOffset);
   
   sphere(3);
      
   popMatrix();
      
}

//WithPerspective
void drawLadder(ladder ladderToDraw){
  
 pushMatrix();

  //translate(ladderToDraw.topLeft.x, ladderToDraw.topLeft.y, ladderToDraw.topLeft.z);

  fill(40, 10, 220);

  //rotateX(radians(90));
  //rotateY(ladderToDraw.rotation);
  //rotateY(radians(90));

  beginShape();
  
  texture(ladderTextureImage);

   vertex(ladderToDraw.topLeft.x, ladderToDraw.topLeft.y, ladderToDraw.topLeft.z,0,0);
   vertex(ladderToDraw.topRight.x, ladderToDraw.topRight.y, ladderToDraw.topRight.z,73,0);
   vertex(ladderToDraw.bottomRight.x, ladderToDraw.bottomRight.y, ladderToDraw.bottomRight.z,73,257);
   vertex(ladderToDraw.bottomLeft.x, ladderToDraw.bottomLeft.y, ladderToDraw.bottomLeft.z,0,257);
   vertex(ladderToDraw.topLeft.x, ladderToDraw.topLeft.y, ladderToDraw.topLeft.z,0,0);

  int ladderWidth = ladderToDraw.ladderWidth;
  int ladderHeight = ladderToDraw.ladderHeight;

  /*vertex(-ladderWidth/2, -ladderHeight/2, 20);
  vertex(ladderWidth/2, -ladderHeight/2, 20);
  vertex(ladderWidth/2, ladderHeight/2, 20);
  vertex(-ladderWidth/2, ladderHeight/2, 20);
  vertex(-ladderWidth/2, -ladderHeight/2, 20);*/

  endShape();

  popMatrix(); 
}