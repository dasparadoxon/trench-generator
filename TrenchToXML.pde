import java.io.File;
import java.util.logging.*;

class TrenchToXML {

  XML trenchXml;

  boolean debug = true;

  String fileName = "trench.xml";


  XML sandbagContainer;
  XML woodWallElementsContainer;

  void log(String message) {

    if (debug)
      print(message+"\n");
  }

  TrenchToXML() {

    setUpXML();
  }

  void setUpXML() {

    String fileToDelete =  dataPath("")+"/"+fileName;

    File f = new File(fileToDelete);

    if (f.exists()) {
      f.delete();
    }    

    trenchXml = new XML("trench");

    sandbagContainer = createSandbagContainer();

    woodWallElementsContainer = createWoodWallElementsContainer();

    //ladderContainer = createLadderContainer();
  }

  XML createOutline(String name, String materialName, String type) {

    XML newOutlineToReturn;

    newOutlineToReturn = trenchXml.addChild("outline");

    XML nameXML = newOutlineToReturn.addChild("name");
    nameXML.setContent(name);

    XML materialNameXML = newOutlineToReturn.addChild("material");
    materialNameXML.setContent(materialName); 

    newOutlineToReturn.setString("type", type);

    return newOutlineToReturn;
  }

  XML createOutline(String name, String materialName) {

    XML newOutlineToReturn;

    newOutlineToReturn = trenchXml.addChild("outline");

    XML nameXML = newOutlineToReturn.addChild("name");
    nameXML.setContent(name);

    XML materialNameXML = newOutlineToReturn.addChild("material");
    materialNameXML.setContent(materialName); 

    newOutlineToReturn.setString("type", "Unknown");

    return newOutlineToReturn;
  }

  public void addPositionVector(XML parent, float x, float y, float z) {

    XML positionVector;

    positionVector = parent.addChild("positionVector");

    XML vectorAxis;

    vectorAxis = positionVector.addChild("xAxis");
    vectorAxis.setContent(String.valueOf(x));

    vectorAxis = positionVector.addChild("yAxis");
    vectorAxis.setContent(String.valueOf(y));

    vectorAxis = positionVector.addChild("zAxis");
    vectorAxis.setContent(String.valueOf(z));
  }

  public void addPositionVector(XML parent, int x, int y, int z) {

    XML positionVector;

    positionVector = parent.addChild("positionVector");

    XML vectorAxis;

    vectorAxis = positionVector.addChild("xAxis");
    vectorAxis.setContent(String.valueOf(x));

    vectorAxis = positionVector.addChild("yAxis");
    vectorAxis.setContent(String.valueOf(y));

    vectorAxis = positionVector.addChild("zAxis");
    vectorAxis.setContent(String.valueOf(z));
  }

  public XML createSandbagContainer() {

    XML newSandbagContainerToReturn;

    newSandbagContainerToReturn = trenchXml.addChild("sandbags");

    return newSandbagContainerToReturn;
  }

  public XML createWoodWallElementsContainer() {

    XML newWoodWallElementsContainer;

    newWoodWallElementsContainer = trenchXml.addChild("woodWallElements");

    return newWoodWallElementsContainer;
  }

  public void addWoodWallElement(PVector centerPosition, float rotation,float lengthOfElement) {

    XML newWoodWallElementXML;

    newWoodWallElementXML = woodWallElementsContainer.addChild("woodWallElement");

    addPositionVector(newWoodWallElementXML, centerPosition.x, centerPosition.y, centerPosition.z);

    XML rotationXML;

    rotationXML = newWoodWallElementXML.addChild("rotation");
    rotationXML.setContent(String.valueOf(rotation));
    
    XML lengthOfElementXML;

    lengthOfElementXML = newWoodWallElementXML.addChild("lengthOfElement");
    lengthOfElementXML.setContent(String.valueOf(lengthOfElement));    
  }

  public void addLadder(Ladder ladder) {

    XML newLadder;

    newLadder = createOutline("Ladder", "ladderMaterial");

    addPositionVector(newLadder, ladder.topLeft.x, ladder.topLeft.y, ladder.topLeft.z);
    addPositionVector(newLadder, ladder.topRight.x, ladder.topRight.y, ladder.topRight.z);
    addPositionVector(newLadder, ladder.bottomRight.x, ladder.bottomRight.y, ladder.bottomRight.z);
    addPositionVector(newLadder, ladder.bottomLeft.x, ladder.bottomLeft.y, ladder.bottomLeft.z);
  }   


  public void addSandbag(float x, float y, float z, float rotation) {

    XML newSandbag;

    newSandbag = sandbagContainer.addChild("sandbag");

    XML vectorAxisXML;

    vectorAxisXML = newSandbag.addChild("xAxis");
    vectorAxisXML.setContent(String.valueOf(x));

    vectorAxisXML = newSandbag.addChild("yAxis");
    vectorAxisXML.setContent(String.valueOf(y));

    vectorAxisXML = newSandbag.addChild("zAxis");
    vectorAxisXML.setContent(String.valueOf(z));

    XML rotationXML;

    rotationXML = newSandbag.addChild("rotation");
    rotationXML.setContent(String.valueOf(rotation));

    XML materialXML;

    materialXML = newSandbag.addChild("sandBag");
    materialXML.setContent("sandbag");
  }  


  void saveToFile() {

    log("Save Trench to XML File");

    saveXML(trenchXml, dataPath("")+"/"+fileName);
  }
}