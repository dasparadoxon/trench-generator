class CircleTrenchDrawer extends TrenchDrawer{

  static final String OUTSIDE = "OUTSIDE";
  static final String INSIDE = "INSIDE";    

  static final int ringDividerIndex = 4;

  CircleTrench trench;


  CircleTrenchDrawer(CircleTrench trenchToDraw,HashMap<String, PImage> texturePool) {
    
    textures = texturePool;

    trench = trenchToDraw;
  }
  

  void drawTrench() {

    background(255, 255, 255);

    scale(0.4);
    translate(-width/2, -height/2);
    rotateX(PI/4);

    fill(81, 89, 0);

    drawTrenchLine(trench.outerTrenchLine, new PVector(0, 1, 0), OUTSIDE);
    drawTrenchLine(trench.innerTrenchLine, new PVector(0, 1, 0), INSIDE);

    fill(137, 87, 51);

    drawTrenchWalls(trench.outerTrenchWall, new PVector(0, 1, 0), OUTSIDE);
    drawTrenchWalls(trench.innerTrenchWall, new PVector(0, 1, 0), INSIDE);

    fill(111, 111, 0);

    drawTrenchFloor(trench.outerTrenchLine, new PVector(0, 1, -100));
    
    
    //drawTrenchWoodWalls(trench.outerTrenchWoodWalls);
    
    //drawTrenchWoodWalls(trench.innerTrenchWoodWalls);


    /*

     fill(81, 89, 0);
     
     drawTrenchLine3D(trench.leftTrenchLine, new PVector(0, 1, 0));
     drawTrenchLine3D(trench.rightTrenchLine, new PVector(0, 1, 0));
     
     fill(137, 87, 51);
     
     drawTrenchWalls3D(trench.leftTrenchWall, new PVector(0, 1, 0));
     drawTrenchWalls3D(trench.rightTrenchWall, new PVector(0, 1, 0));
     
     fill(111, 111, 0);
     
     drawTrenchFloor3D(trench.trenchFloor, new PVector(0, 1, 0));
     
     drawTrenchWoodWalls(trench.leftTrenchWoodWalls);
     drawTrenchWoodWalls(trench.rightTrenchWoodWalls);
     
     drawBarbedWireRows(trench.barbedWireRows);
     
     */
  }  


  /*************************************************************************************
   *
   *************************************************************************************/
  void drawTrenchLine(ArrayList<PVector> toDraw, PVector positionToDraw, String alignment) {

    pushMatrix();

    beginShape();

    int pointIndex = 0;

    for (PVector circlePoint : toDraw) {

      if (alignment==OUTSIDE)  
        if (pointIndex == 5)
          beginContour();

      if (alignment==OUTSIDE)
        vertex(circlePoint.x, circlePoint.y, circlePoint.z);

      if (alignment==INSIDE )
        vertex(circlePoint.x, circlePoint.y, circlePoint.z);

      pointIndex++;
    }
    if (alignment==OUTSIDE) 
      endContour();

    endShape();

    popMatrix();
  }  

  /*************************************************************************************
   *
   *************************************************************************************/
  void drawTrenchFloor(ArrayList<PVector> floorToDraw, PVector positionToDraw) {

    beginShape();

    int firstHalfOfShapeCounter = 0;

    for (PVector trenchWallPoint : floorToDraw) {

      if (firstHalfOfShapeCounter > 4)

        //print(trenchWallPoint);

        vertex(positionToDraw.x + trenchWallPoint.x, positionToDraw.y + trenchWallPoint.y, positionToDraw.z + trenchWallPoint.z);

      firstHalfOfShapeCounter++;
    }


    endShape();
  }

  /*************************************************************************************
   *
   *************************************************************************************/
  void drawTrenchWalls(ArrayList<ArrayList<PVector>> wallsToDraw, PVector positionToDraw, String alignment) {

    int c = 0;

    PVector prevTrench = new PVector();

    if (alignment == OUTSIDE) {

      for (ArrayList<PVector> trenchWall : wallsToDraw) {

        beginShape();

        for (PVector trenchWallPoint : trenchWall) {

          if (c != ringDividerIndex)
            vertex(positionToDraw.x + trenchWallPoint.x, positionToDraw.y + trenchWallPoint.y, positionToDraw.z + trenchWallPoint.z);
        }

        endShape();

        c++;
      }
    }

    if (alignment == INSIDE) {

      for (ArrayList<PVector> trenchWall : wallsToDraw) {

        beginShape();

        for (PVector trenchWallPoint : trenchWall) {

          //if (c != ringDividerIndex)
            vertex(positionToDraw.x + trenchWallPoint.x, positionToDraw.y + trenchWallPoint.y, positionToDraw.z + trenchWallPoint.z);
        }

        endShape();

        c++;
      }
    }
  };


  void drawTrenchWoodWalls(ArrayList<TrenchWoodWall> trenchWoodWallsToDraw) {

    int i = 0;

    for (TrenchWoodWall trenchWoodWallToDraw : trenchWoodWallsToDraw) {

      i++;

      for (TrenchWoodWallElement trenchWallElement : trenchWoodWallToDraw.wallElements) {

        pushMatrix();

        fill(203, 127, 26);

        translate(trenchWallElement.centerPosition.x, trenchWallElement.centerPosition.y, trenchWallElement.centerPosition.z);

        rotateZ(trenchWallElement.rotation);

        box(10, trenchWallElement.lengthOfElement, trenchWoodWallToDraw.heightOfWoodElement);

        popMatrix();
      }

      // draw poles

      TrenchWoodWallElement firstWallElement = trenchWoodWallToDraw.wallElements.get(0);

      pushMatrix();

      fill(0, 0, 0);

      translate(trenchWoodWallToDraw.originVector.x, trenchWoodWallToDraw.originVector.y, trenchWoodWallToDraw.originVector.z - 40);

      box(15, 15, 100);

      popMatrix();

      if (trenchWoodWallToDraw.hasLadder)
        drawLadder(trenchWoodWallToDraw.theLadder);

      drawSandBags(trenchWoodWallToDraw.sandBags);
    }

    TrenchWoodWall lastWall = trenchWoodWallsToDraw.get(trenchWoodWallsToDraw.size()-1);

    pushMatrix();

    fill(0, 0, 0);

    translate(lastWall.secondVector.x, lastWall.secondVector.y, lastWall.secondVector.z - 40);

    box(15, 15, 100);

    popMatrix();

    if (lastWall.hasLadder)
      drawLadder(lastWall.theLadder);

    drawSandBags(lastWall.sandBags);
  }

  void drawSandBags(ArrayList<SandBag> trenchWoodWallToPutSandBagsOn) {

    for (SandBag sandBagToDraw : trenchWoodWallToPutSandBagsOn) {

      pushMatrix();

      translate(sandBagToDraw.centerPosition.x, sandBagToDraw.centerPosition.y, sandBagToDraw.centerPosition.z);

      rotateZ(sandBagToDraw.rotation);

      fill(212, 184, 101);  

      box(15, sandBagToDraw.lengthOfBag, 15);

      popMatrix();
    }
  }

  void drawBarbedWireRows(ArrayList<RowOfBarbedWire> barbedWireRowsToDraw) {

    for (RowOfBarbedWire barbedWireRowToDraw : barbedWireRowsToDraw) {

      PVector pos = barbedWireRowToDraw.centerPosition.copy();

      pushMatrix();

      beginShape();

      int lengthOfRow = 60;
      int heightOfRow = 20;
      int widthOfRow = 120;

      texture(textures.get("barbedWireTextureImage"));
      textureMode(NORMAL);

      noStroke();

      vertex(pos.x, pos.y + lengthOfRow, pos.z - heightOfRow, 0, 0);
      vertex(pos.x, pos.y + lengthOfRow, pos.z + heightOfRow, 0, 1);
      vertex(pos.x, pos.y - lengthOfRow, pos.z + heightOfRow, 1, 1);
      vertex(pos.x, pos.y - lengthOfRow, pos.z - heightOfRow, 1, 0);
      vertex(pos.x, pos.y + lengthOfRow, pos.z - heightOfRow, 0, 0);      

      stroke(0);

      endShape();

      rotateY(radians(90));

      popMatrix();
    }
  }

  //WithPerspective
  void drawLadder(Ladder ladderToDraw) {

    pushMatrix();

    fill(40, 10, 220);

    beginShape();

    noStroke();

    texture(textures.get("ladderTextureImage"));

    textureMode(IMAGE);

    vertex(ladderToDraw.topLeft.x, ladderToDraw.topLeft.y, ladderToDraw.topLeft.z, 0, 0);
    vertex(ladderToDraw.topRight.x, ladderToDraw.topRight.y, ladderToDraw.topRight.z, 73, 0);
    vertex(ladderToDraw.bottomRight.x, ladderToDraw.bottomRight.y, ladderToDraw.bottomRight.z, 73, 257);
    vertex(ladderToDraw.bottomLeft.x, ladderToDraw.bottomLeft.y, ladderToDraw.bottomLeft.z, 0, 257);
    vertex(ladderToDraw.topLeft.x, ladderToDraw.topLeft.y, ladderToDraw.topLeft.z, 0, 0);

    int ladderWidth = ladderToDraw.ladderWidth;
    int ladderHeight = ladderToDraw.ladderHeight;

    stroke(0);

    endShape();

    popMatrix();
  }
}