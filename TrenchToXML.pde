

class TrenchToXML {

  XML trenchXml;

  boolean debug = true;

  String fileName = "trench.xml";

  void log(String message) {

    if (debug)
      print(message+"\n");
  }

  TrenchToXML() {

    setUpXML();
  }

  void setUpXML() {

    trenchXml = new XML("trench");
  }

  XML createOutline(String name) {
    
    XML newOutlineToReturn;
    
    newOutlineToReturn = trenchXml.addChild("outline");
    
    XML nameXML = newOutlineToReturn.addChild("name");
    nameXML.setContent(name);

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

  void saveToFile() {

    log("Save Trench to XML File");

    saveXML(trenchXml, dataPath("")+"/"+fileName);
  }
}