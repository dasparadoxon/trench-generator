

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
    
    trenchXml = new XML("Trench");
    
    XML outline = xml.addChild("outline");
    
    addPositionVector(outline,12.4,4,62.0);
    addPositionVector(outline,142.4,44,32.0);
    addPositionVector(outline,112.4,24,82.0);
    
    
    

  }
  
  void addPositionVector(XML parent,float x,float y,float z){
    
    XML positionVector;
    
    positionVector = parent.addChild("positionVector");
    
    XML vectorAxis;
    
    vectorAxis = positionVector.addChild("xAxis");
    vectorAxis.setContent("12.0");
    vectorAxis = positionVector.addChild("yAxis");
    vectorAxis.setContent("52.0");
    vectorAxis = positionVector.addChild("zAxis");
    vectorAxis.setContent("112.0");
    
  }

  void saveToFile() {

    log("Save Trench to XML File");
    
    saveXML(trenchXml, dataPath("")+"/"+fileName);
  }
}