import java.util.logging.*;



class Battlefield {
  
  private final Logger LOGGER = Logger.getLogger( Battlefield.class.getName() );

  PVector dimensions = new PVector(); 

  Battlefield(int bWidth, int bHeight) {

    dimensions.x = bWidth;
    dimensions.y = bHeight;
  }
}

class RowOfBarbedWire {
  
  private final Logger LOGGER = Logger.getLogger( RowOfBarbedWire.class.getName() );

  PVector centerPosition;
  PVector dimensions;

  int rotationZ = 0;

  RowOfBarbedWire() {
  }
}

class TrenchWoodWallElement {
  
  private final Logger LOGGER = Logger.getLogger( TrenchWoodWallElement.class.getName() );

  float rotation;
  PVector centerPosition;
  float lengthOfElement;
}

class Pole {
  
  private final Logger LOGGER = Logger.getLogger( Pole.class.getName() );

  float rotation;
  PVector centerPosition;
  float lengthOfElement;
}

class Ladder {
  
  private final Logger LOGGER = Logger.getLogger( Ladder.class.getName() );

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
  
  private final Logger LOGGER = Logger.getLogger( SandBag.class.getName() );

  public static final int lengthOfBag = 31;

  PVector centerPosition;

  float rotation;
}