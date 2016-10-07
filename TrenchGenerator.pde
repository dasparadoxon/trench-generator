import java.util.Map.*; 
import peasy.*;
import controlP5.*;


final String CIRCLEMODE = "CIRCLEMODE";
final String LINEMODE = "LINEMODE";


class TrenchGenerator {

  HashMap<String, PImage> textures;

  String shapeMode = CIRCLEMODE;

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
  
  PeasyCam camera;
  
  PApplet app;

  TrenchGenerator(PeasyCam cameraToUse,ControlP5 guiToUse,PApplet appToUse) {
    
    camera = cameraToUse;
    cp5 = guiToUse;
    app = appToUse;

    setupProcessingVideo();
  }

  void setupProcessingVideo() {

    textures = new HashMap<String, PImage>();



    numberOfTrenchBents = 7;

    

    setupGUI();

    loadTextures();   

    stroke(0, 0, 0);

    




    regenerate = true;
  }

  void loadTextures() {
    
    ladderTextureImage = loadImage("ladder.png");

    barbedWireTextureImage = loadImage("stacheldraht.png");
    
    textures.put("barbedWireTextureImage",ladderTextureImage);
    
    textures.put("barbedWireTextureImage",barbedWireTextureImage); 
  }

  void exportToXML(float value) {

    trenchToXML.saveToFile();
  }



  void draw() throws IOException{

    if (regenerate) {

      TrenchToXML trenchToXML = new TrenchToXML(); 
      
      circleTrench = new CircleTrench();
      circleTrench.setBattlefield(battlefield);
      circleTrench.setNumberOfTrenchBents(numberOfTrenchBents);
      circleTrench.setTrenchToXML(trenchToXML);
      circleTrenchDrawer = new CircleTrenchDrawer(circleTrench,textures);
  
  
      lineTrench = new Trench();
      lineTrench.setBattlefield(battlefield);
      lineTrench.setNumberOfTrenchBents(numberOfTrenchBents);
      lineTrench.setTrenchToXML(trenchToXML);
      lineTrenchDrawer = new TrenchDrawer(lineTrench,textures);      


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


    cp5.setAutoDraw(false);  

    cp5.addButton("exportToXML")
      .setValue(0)
      .setCaptionLabel("EXPORT TO XML")
      .setPosition(width-160, 60)
      .setSize(140, 20)
      ;  

    modeDrownDown = cp5.addDropdownList("modeDropDownFunction")
      .setPosition(width-160, 20)
      .setWidth(140)
      .setCaptionLabel("MODES");
    ;

    customizeModeDropDown(modeDrownDown);

    trenchBentsSlider = cp5.addSlider("sliderValue")
      .setPosition(20, 20)
      .setRange(1, 50)
      .setValue(7)
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
}