/*************************************************************************************
 * WW1 TRENCH GENERATOR
 * 
 * Creates a trench which parameters can be live changed and exportet to XML 
 * for use in other programms
 * 
 *************************************************************************************/
import controlP5.*;
import peasy.*;

TrenchGenerator trenchGenerator;

  
PeasyCam camera;
ControlP5 cp5;

void setup(){
  
  size(800, 800, P3D);
  
  setUpCameraLibrary();
  
  setUpGUILibrary();

  trenchGenerator = new TrenchGenerator(camera,cp5,this); 
  
}

void draw(){
  
  try{
  
    trenchGenerator.draw();
  
  } catch(Exception exception){
    
    //print(exception.getStackTrace()[0].getLineNumber());
    
    print(exception.getMessage());
    //exception.printStackTrace();
    exit();
  }
}

void setUpCameraLibrary(){
  
    camera = new PeasyCam(this, 0, 0, 0, 500);
}

void setUpGUILibrary(){

    cp5 = new ControlP5(this);
}