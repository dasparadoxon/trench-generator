import java.io.File;
import java.util.logging.*;

class TrenchToXML {
  
  private final Logger LOGGER = Logger.getLogger( TrenchToXML.class.getName() );

  XML trenchXml;
  
  XML sandbagContainer;
  XML woodWallElementsContainer;

  String fileName = "trench.xml";
  
  int outlines = 0;

  TrenchToXML() {
    
    setLogger(LOGGER,Trench.class.getName(),Level.INFO);
    
    String callerClassName = new Exception().getStackTrace()[1].getClassName();
    
    //setLogger(LOGGER, TrenchToXML.class.getName(),Level.FINE);
    //LOGGER.setLevel(Level.FINEST);
    
    LOGGER.info("TrenchToXML called from : "+callerClassName);

    setUpXML();
  }

  void setUpXML() {

    String fileToDelete =  dataPath("")+"/"+fileName;
    
    LOGGER.info("XML Output path and filename to delete : "+fileToDelete);
    LOGGER.setLevel(Level.FINEST);

    File f = new File(fileToDelete);

    if (f.exists()) {
      LOGGER.info("XML File exists, deleting.");
      f.delete();
    }    

    trenchXml = new XML("trench");

    sandbagContainer = createSandbagContainer();

    woodWallElementsContainer = createWoodWallElementsContainer();

    //ladderContainer = createLadderContainer();
  }

  XML createOutline(String name, String materialName, String type) {
    
    outlines++;
    
    LOGGER.info("Creating outline for :"+name+" with material : "+materialName+" and type :"+type);

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
    
    LOGGER.finest("Add Position Vector : X:"+x+" Y:"+y+" Z:"+z);

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
    
     LOGGER.finest("Add Position Vector INT : X:"+x+" Y:"+y+" Z:"+z);

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
    
     LOGGER.fine("Creating Sandbag Container");

    XML newSandbagContainerToReturn;

    newSandbagContainerToReturn = trenchXml.addChild("sandbags");

    return newSandbagContainerToReturn;
  }

  public XML createWoodWallElementsContainer() {
    
    LOGGER.finest("Creating Woodwall Element Container");

    XML newWoodWallElementsContainer;

    newWoodWallElementsContainer = trenchXml.addChild("woodWallElements");

    return newWoodWallElementsContainer;
  }

  public void addWoodWallElement(PVector centerPosition, float rotation,float lengthOfElement) {
    
    LOGGER.fine("Adding WoodWall Element at "+centerPosition.toString()+" Rotation:"+rotation+" Length :"+lengthOfElement);

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
    
    LOGGER.finest("Adding Ladder.");

    XML newLadder;

    newLadder = createOutline("Ladder", "ladderMaterial");

    addPositionVector(newLadder, ladder.topLeft.x, ladder.topLeft.y, ladder.topLeft.z);
    addPositionVector(newLadder, ladder.topRight.x, ladder.topRight.y, ladder.topRight.z);
    addPositionVector(newLadder, ladder.bottomRight.x, ladder.bottomRight.y, ladder.bottomRight.z);
    addPositionVector(newLadder, ladder.bottomLeft.x, ladder.bottomLeft.y, ladder.bottomLeft.z);
  }   


  public void addSandbag(float x, float y, float z, float rotation) {
    
    LOGGER.finest("Adding Sandbag");

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

    LOGGER.info("Save Trench to XML File");
    LOGGER.info("Number of Shapes : "+outlines);
    LOGGER.info("Number of Sandbags : "+sandbagContainer.getChildren().length);
    LOGGER.info("Number of Woodwall Elements :" + woodWallElementsContainer.getChildren().length);

    saveXML(trenchXml, dataPath("")+"/"+fileName);
  }
}