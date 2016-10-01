import java.io.File;

class TrenchToXML {

  XML trenchXml;

  boolean debug = true;

  String fileName = "trench.xml";
  
  
  XML sandbagContainer;

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
    
  }

  XML createOutline(String name, String materialName) {

    XML newOutlineToReturn;

    newOutlineToReturn = trenchXml.addChild("outline");

    XML nameXML = newOutlineToReturn.addChild("name");
    nameXML.setContent(name);

    XML materialNameXML = newOutlineToReturn.addChild("material");
    materialNameXML.setContent(materialName);    

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

  public void addSandbag(float x, float y, float z,float rotation) {

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
    
  }  


  void saveToFile() {

    log("Save Trench to XML File");

    saveXML(trenchXml, dataPath("")+"/"+fileName);
  }
}