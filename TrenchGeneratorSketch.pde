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
  
  setUpCameraLibrary();
  
  setUpGUILibrary();

  trenchGenerator = new TrenchGenerator(camera,cp5,this); 
  
}

void draw(){
  
  trenchGenerator.draw();
}

void setUpCameraLibrary(){
  
    camera = new PeasyCam(this, 0, 0, 0, 500);
}

void setUpGUILibrary(){

    cp5 = new ControlP5(this);
}