class TrenchDrawer {
  
    
  HashMap<String, PImage> textures;

  Trench trench;

  TrenchDrawer() {

      
  }
  

  TrenchDrawer(Trench trenchToDraw) {

    trench = trenchToDraw;
  }
  

  void drawTrench() {

    background(255, 255, 255);

    scale(0.4);
    translate(-width/2, -height/2);
    rotateX(PI/4);

     fill(81, 89, 0);
     
     drawTrenchLine(trench.leftTrenchLine, new PVector(0, 1, 0));
     drawTrenchLine(trench.rightTrenchLine, new PVector(0, 1, 0));
     
     fill(137, 87, 51);
     
     drawTrenchWalls(trench.leftTrenchWall, new PVector(0, 1, 0));
     drawTrenchWalls(trench.rightTrenchWall, new PVector(0, 1, 0));
     
     fill(111, 111, 0);
     
     drawTrenchFloor(trench.trenchFloor, new PVector(0, 1, 0));
     
     drawTrenchWoodWalls(trench.leftTrenchWoodWalls);
     drawTrenchWoodWalls(trench.rightTrenchWoodWalls);
     
     drawBarbedWireRows(trench.barbedWireRows);

  }  

  void drawTrenchFloor(ArrayList<PVector> floorToDraw, PVector positionToDraw) {

    beginShape();

    for (PVector trenchWallPoint : floorToDraw) {


      vertex(positionToDraw.x + trenchWallPoint.x, positionToDraw.y + trenchWallPoint.y, positionToDraw.z + trenchWallPoint.z);
    }

    endShape();
  }

  void drawTrenchWalls(ArrayList<ArrayList<PVector>> wallsToDraw, PVector positionToDraw) {

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


  void drawTrenchLine(ArrayList<PVector> toDraw, PVector positionToDraw) {


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