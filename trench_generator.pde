/*************************************************************************************
 * WW1 TRENCH GENERATOR
 * 
 * Creates a trench which parameters can be live changed and exportet to XML 
 * for use in other programms
 * 
 *************************************************************************************/
import controlP5.*;



static final String CIRCLEMODE = "CIRCLEMODE";
static final String LINEMODE = "LINEMODE";

String shapeMode = CIRCLEMODE;

import peasy.*;

PeasyCam camera;

ControlP5 cp5;

int pressed = 0;

int sliderValue = 100;

Slider trenchBentsSlider;
Slider battleFieldDimensionSlider;

CircleTrench circleTrench;
CircleTrenchDrawer circleTrenchDrawer;

Trench lineTrench;
TrenchDrawer lineTrenchDrawer;

boolean regenerate;

PImage ladderTextureImage;
PImage barbedWireTextureImage;

int numberOfTrenchBents = 10;

DropdownList modeDrownDown;

RadioButton modeRadioButton;

Battlefield battlefield = new Battlefield(1800, 1800);

TrenchToXML trenchToXML = new TrenchToXML(); 

void setup() {

  numberOfTrenchBents = 30;

  size(800, 800, P3D);

  setupGUI();
  
  trenchToXML.saveToFile();


  ladderTextureImage = loadImage("ladder.png");

  barbedWireTextureImage = loadImage("stacheldraht.png");

  stroke(0, 0, 0);

  camera = new PeasyCam(this, 0, 0, 0, 500);


  circleTrench = new CircleTrench();
  circleTrenchDrawer = new CircleTrenchDrawer(circleTrench);


  lineTrench = new Trench();
  lineTrenchDrawer = new TrenchDrawer(lineTrench);

  regenerate = true;
}



void draw() {

  if (regenerate) {

    lineTrench.generateTrench();
    circleTrench.generateTrench();    

    regenerate = false;
  }


  if (shapeMode == LINEMODE)
    lineTrenchDrawer.drawTrench();

  if (shapeMode == CIRCLEMODE)
    circleTrenchDrawer.drawTrench();



  gui();
}

void setupGUI() {


  cp5 = new ControlP5(this);

  cp5.setAutoDraw(false);  

  modeDrownDown = cp5.addDropdownList("modeDropDownFunction")
    .setPosition(width-160, 20)
    .setWidth(140)
    .setCaptionLabel("MODES");
  ;

  customizeModeDropDown(modeDrownDown);

  trenchBentsSlider = cp5.addSlider("sliderValue")
    .setPosition(20, 20)
    .setRange(1, 50)
    .setValue(15)
    .setWidth(200)
    .setHeight(20)
    .setCaptionLabel("TRENCH BENTS");

  ;  

  battleFieldDimensionSlider = cp5.addSlider("battleFieldDimensions")
    .setPosition(20, 60)
    .setRange(600, 4000)
    .setValue(800)
    .setWidth(200)
    .setHeight(20)
    .setCaptionLabel("BATTLEFIELD DIMENSIONS");

  ;
}


void customizeModeDropDown(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  //ddl.captionLabel("TRENCH BENTS").set("dropdown");
  //ddl.captionLabel().style().marginTop = 3;
  //ddl.captionLabel().style().marginLeft = 3;
  //ddl.valueLabel().style().marginTop = 3;

  ddl.addItem("Line", 1);
  ddl.addItem("Circle", 2);

  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
  ddl.setValue(0);
  ddl.close();
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
  rect(10, 10, 320, 80);
  rect(width-170, 10, 160, 80);
  cp5.draw();
  camera.endHUD();
  hint(ENABLE_DEPTH_TEST);
}

void sliderValue(float trenchBentsSliderValue) {

  if (trenchBentsSliderValue>1) {

    numberOfTrenchBents = (int)trenchBentsSliderValue;

    regenerate = true;
  }
}

void battleFieldDimensions(float battleFieldDimensionsValue) {

  if (battleFieldDimensionsValue>1) {

    battlefield.dimensions.set(new PVector(battleFieldDimensionsValue, battleFieldDimensionsValue, 0));

    regenerate = true;
  }
}


void modeDropDownFunction(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.

  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    //println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } else if (theEvent.isController()) {
    //println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());

    if (theEvent.getController().getValue() == 0)
      shapeMode = LINEMODE;

    if (theEvent.getController().getValue() == 1)
      shapeMode = CIRCLEMODE;
  }
}