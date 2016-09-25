/*************************************************************************************
* WW1 TRENCH GENERATOR
* 
* Creates a trench which parameters can be live changed and exportet to XML 
* for use in other programms
* 
*************************************************************************************/
import controlP5.*;

import java.io.File;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;

import peasy.*;

PeasyCam camera;

ControlP5 cp5;

int pressed = 0;

int sliderValue = 100;

Slider trenchBentsSlider;
Slider battleFieldDimensionSlider;

Trench trench;
TrenchDrawer trenchDrawer;

boolean regenerate;

PImage ladderTextureImage;
PImage barbedWireTextureImage;

int numberOfTrenchBents = 10;

Battlefield battlefield = new Battlefield(1800,1800);

void setUpXML(){
 
  //DocumentBuilderFactory factory =
  //  DocumentBuilderFactory.newInstance();
  //DocumentBuilder builder = factory.newDocumentBuilder();
}

void setup() {
  
  //setUpXML();
  
  numberOfTrenchBents = 30;

  size(800, 800, P3D);
  
  cp5 = new ControlP5(this);
  
  cp5.setAutoDraw(false);
  
  ladderTextureImage = loadImage("ladder.png");
  
  barbedWireTextureImage = loadImage("stacheldraht.png");
  
  trenchBentsSlider = cp5.addSlider("sliderValue")
     .setPosition(20,20)
     .setRange(1,50)
     .setValue(15)
     .setWidth(200)
     .setHeight(20)
     .setCaptionLabel("TRENCH BENTS");
     
     ;  
     
  battleFieldDimensionSlider = cp5.addSlider("battleFieldDimensions")
     .setPosition(20,60)
     .setRange(600,4000)
     .setValue(800)
     .setWidth(200)
     .setHeight(20)
     .setCaptionLabel("BATTLEFIELD DIMENSIONS");
     
     ;     

  stroke(0, 0, 0);

  camera = new PeasyCam(this, 0, 0, 0, 500);
  
  trench = new Trench();
  trenchDrawer = new TrenchDrawer(trench);

  regenerate = true;
}

void draw() {
  
  if(regenerate){
    
      trench.generateStraightTrench();
      
      regenerate = false;
  }

  trenchDrawer.drawTrench();
  
  gui();
}



void keyPressedToGenerate() {

  if (   keyPressed == true && pressed == 0)
    pressed++;

  if (pressed == 1) {
    pressed = 2;

    //generate();

  }

  if (keyPressed == false && pressed == 2) {

    pressed = 0;
  }
}



/*************************************************************************************
*
*************************************************************************************/
void gui() {
  hint(DISABLE_DEPTH_TEST);
  camera.beginHUD();
  rect(10,10,320,80);
  cp5.draw();
  camera.endHUD();
  hint(ENABLE_DEPTH_TEST);
}

void sliderValue(float trenchBentsSliderValue) {
  
    if(trenchBentsSliderValue>1){
  
      numberOfTrenchBents = (int)trenchBentsSliderValue;

      regenerate = true;
    }
}

void battleFieldDimensions(float battleFieldDimensionsValue){
 
  if(battleFieldDimensionsValue>1){
  
    battlefield.dimensions.set(new PVector(battleFieldDimensionsValue,battleFieldDimensionsValue,0));
    
    regenerate = true;
  }
  
}