class Battlefield {

  PVector dimensions = new PVector(); 

  Battlefield(int bWidth, int bHeight) {

    dimensions.x = bWidth;
    dimensions.y = bHeight;
  }
}

class RowOfBarbedWire {

  PVector centerPosition;
  PVector dimensions;

  int rotationZ = 0;

  RowOfBarbedWire() {
  }
}

class TrenchWoodWallElement {

  float rotation;
  PVector centerPosition;
  float lengthOfElement;
}

class Pole {

  float rotation;
  PVector centerPosition;
  float lengthOfElement;
}

class Ladder {

  PVector topLeft;
  PVector topRight;
  PVector bottomLeft;
  PVector bottomRight;  

  float w, h;
  float rotation;

  int leaderHeight = 10;

  int ladderWidth = 30;
  int ladderHeight = 70;
}

class SandBag {

  public static final int lengthOfBag = 31;

  PVector centerPosition;

  float rotation;
}