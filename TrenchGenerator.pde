import java.util.Map.*; 
import peasy.*;
import controlP5.*;
import java.util.logging.*;

final String CIRCLEMODE = "CIRCLEMODE";
final String LINEMODE = "LINEMODE";

//private static final Logger LOGGER = Logger.getLogger( TrenchGenerator.class.getName() );

class TrenchGenerator {

  Group lineModeControllerGroup;
  Group circleModeControllerGroup;  

  private final Logger LOGGER = Logger.getLogger( TrenchGenerator.class.getName() );

  HashMap<String, PImage> textures;

  String shapeMode = CIRCLEMODE;

  ControlP5 cp5;

  int pressed = 0;

  int sliderValue = 100;

  Slider trenchBentsSlider;
  Slider battleFieldDimensionSlider;
  Slider battleFieldDimensionSlider2;
  Slider circleRadiusSlider;
  Slider numberOfCircleSegmentsSlider;

  Button exportButton;

  CircleTrench circleTrench;
  CircleTrenchDrawer circleTrenchDrawer;

  Trench lineTrench;
  TrenchDrawer lineTrenchDrawer;

  boolean regenerate;

  PImage ladderTextureImage;
  PImage barbedWireTextureImage;

  int numberOfTrenchBents = 15;
  int numberOfCircleSegments = 8;
  float circleRadius = 250;

  DropdownList modeDrownDown;

  RadioButton modeRadioButton;

  Battlefield battlefield;

  TrenchToXML trenchToXML;   

  PeasyCam camera;

  PApplet app;

  boolean circleModeAvailable = true;

  TrenchGenerator(PeasyCam cameraToUse, ControlP5 guiToUse, PApplet appToUse) throws Exception {

    setLogger(LOGGER, TrenchGenerator.class.getName(), Level.INFO);

    LOGGER.log(Level.INFO, "Trench Generator Constructor");

    camera = cameraToUse;
    cp5 = guiToUse;
    app = appToUse;

    setupGenerator();
  }

  void setupGenerator() throws Exception {

    LOGGER.info("Setting up Trench Generator");

    textures = new HashMap<String, PImage>();

    battlefield = new Battlefield(1800, 1800);

    setupGUI();

    loadTextures();   

    stroke(0, 0, 0);

    regenerate = true;
  }

  public void setShapeMode(String mode) {

    shapeMode = mode;
    regenerate = true;
  }

  void loadTextures() throws Exception {

    ladderTextureImage = loadImage("ladder.png");

    if (ladderTextureImage == null)
      throw new Exception("Could not load Ladder Texture");

    barbedWireTextureImage = loadImage("stacheldraht.png");

    if (barbedWireTextureImage == null)
      throw new Exception("Could not load barbed Wire Texture Image Texture");    

    textures.put("ladderTextureImage", ladderTextureImage);

    textures.put("barbedWireTextureImage", barbedWireTextureImage);
  }

  void exportToXML(float value) {

    LOGGER.info("Method linked to export Button pressed...");

    trenchToXML.saveToFile();
  }

  void draw() throws Exception {

    if (regenerate) {

      LOGGER.log(Level.FINE, "Generating the Trench Data Objects new inside the draw (main loop) method.");

      trenchToXML = new TrenchToXML(); 

      if (shapeMode == CIRCLEMODE ) {

        LOGGER.info("CIRCLEMODE");

        circleTrench = new CircleTrench();
        circleTrench.setBattlefield(battlefield);
        circleTrench.setNumberOfTrenchBents(numberOfTrenchBents);
        circleTrench.setTrenchToXML(trenchToXML);
        circleTrench.setAmplitudeMultiplier((int)circleRadius);
        circleTrench.setCircleSegmentNumber(numberOfCircleSegments);

        circleTrenchDrawer = new CircleTrenchDrawer(circleTrench, textures);
      }

      if (shapeMode == LINEMODE) {

        LOGGER.info("LINEMODE");

        lineTrench = new Trench();
        lineTrench.setBattlefield(battlefield);
        lineTrench.setNumberOfTrenchBents(numberOfTrenchBents);
        lineTrench.setTrenchToXML(trenchToXML);

        lineTrenchDrawer = new TrenchDrawer(lineTrench, textures);      

        lineTrench.generateTrench();
      }

      if (circleModeAvailable && shapeMode == CIRCLEMODE) 
        circleTrench.generateTrench();    

      regenerate = false;

      LOGGER.fine("Finished generating Trench Data for Mode : "+shapeMode);
    }

    LOGGER.fine("shapeMode is : "+shapeMode);

    if (shapeMode == LINEMODE)
      lineTrenchDrawer.drawTrench();

    if (shapeMode == CIRCLEMODE && circleModeAvailable)
      circleTrenchDrawer.drawTrench();

    camera.setMouseControlled(true);

    if (trenchBentsSlider.isInside() || battleFieldDimensionSlider.isInside() || exportButton.isInside() || modeDrownDown.isInside() || circleRadiusSlider.isInside()) {
      camera.setMouseControlled(false);
    }   

    if (shapeMode == LINEMODE) {

      circleModeControllerGroup.hide();
      lineModeControllerGroup.show();
    }

    if (shapeMode == CIRCLEMODE) {

      lineModeControllerGroup.hide();
      circleModeControllerGroup.show();
    }       

    gui();
  }

  void setupGUI() {


    cp5.setAutoDraw(false);  

    exportButton = cp5.addButton("exportToXML")
      .setValue(0)
      .setCaptionLabel("EXPORT TO XML")
      .setPosition(width-160, 20)
      .plugTo(this)
      .setSize(140, 20)
      ;  

    if (circleModeAvailable) {

      modeDrownDown = cp5.addDropdownList("modeDropDownFunction")
        .setPosition(width-160, 50)
        .setWidth(140)
        .setCaptionLabel("MODES");
      ;

      customizeModeDropDown(modeDrownDown);
    }



    lineModeControllerGroup = cp5.addGroup("lineModeControllsGroup")
      .setLabel("LINE MODE CONTROLLER")
    .setBarHeight(20)
      .setPosition(10, 10)
      .setBackgroundHeight(70)
      .setWidth(320)
      .setHeight(70)
      .setBackgroundColor(color(121))
      .hideBar()
      ;

    trenchBentsSlider = cp5.addSlider("sliderValue")
      .setPosition(10, 10)
      .setRange(5, 50)
      .setValue(numberOfTrenchBents)
      .setWidth(200)
      .setHeight(20)
      .setGroup(lineModeControllerGroup)
      .plugTo(this)
      .setCaptionLabel("TRENCH BENTS"); 

    battleFieldDimensionSlider = cp5.addSlider("battleFieldDimensions")
      .setPosition(10, 40)
      .setRange(600, 4000)
      .setValue(battlefield.dimensions.x)
      .setWidth(200)
      .setHeight(20)
      .plugTo(this)
      .setGroup(lineModeControllerGroup)
      .setCaptionLabel("BATTLEFIELD DIMENSIONS");      

    circleModeControllerGroup = cp5.addGroup("circleModeControllsGroup")
    .setLabel("CIRCLE MODE CONTROLLER")
    //.setBarHeight(20)
      .setPosition(10, 10)
      .setBackgroundHeight(100)
      .setWidth(320)
      .setHeight(100)
      .setBackgroundColor(color(121))
      .hideBar()
      ;

    numberOfCircleSegmentsSlider = cp5.addSlider("numberOfCircleSegmentsFunction")
      .setPosition(10, 10)
      .setRange(1, 50)
      .setValue(7)
      .setWidth(200)
      .setHeight(20)
      .plugTo(this)
      .setGroup(circleModeControllerGroup)
      .setCaptionLabel("CIRCLE SEGMENTS");     

    battleFieldDimensionSlider2 = cp5.addSlider("battleFieldDimensionsforCircleTrench")
      .setPosition(10, 40)
      .setRange(600, 4000)
      .setValue(battlefield.dimensions.x)
      .setWidth(200)
      .setHeight(20)
      .plugTo(this)
      .setGroup(circleModeControllerGroup)
      .setCaptionLabel("BATTLEFIELD DIMENSIONS");    
      
    circleRadiusSlider = cp5.addSlider("circleRadiusSlider")
      .setPosition(10, 70)
      .setRange(150, 540)
      .setValue(circleRadius)
      .setWidth(200)
      .setHeight(20)
      .plugTo(this)
      .setGroup(circleModeControllerGroup)
      .setCaptionLabel("CIRCLE RADIUS");         


    if (shapeMode == LINEMODE) {

      circleModeControllerGroup.hide();
      lineModeControllerGroup.show();
    }

    if (shapeMode == CIRCLEMODE) {

      lineModeControllerGroup.hide();
      circleModeControllerGroup.show();
    }
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
    ddl.setValue(2);
    
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
    pushMatrix();
    fill(121);
    //rect(10, 10, 320, 80);

    int rectHeight = 40;

    if (circleModeAvailable)rectHeight = 70;

    rect(width-170, 10, 160, rectHeight);

    popMatrix();
    cp5.draw();
    camera.endHUD();
    hint(ENABLE_DEPTH_TEST);
  }

  void sliderValue(float trenchBentsSliderValue) {

    LOGGER.finest("Received Slider Value Change for Trent Bents Value !");

    if (trenchBentsSliderValue>1) {

      numberOfTrenchBents = (int)trenchBentsSliderValue;

      regenerate = true;
    }
  }
  
  void circleRadiusSlider(float valueCircleRadiusSlider) {

    LOGGER.finest("Received Slider Value Change for Circle Radius !");


      circleRadius = (int)valueCircleRadiusSlider;

      regenerate = true;

  }  

  void battleFieldDimensions(float battleFieldDimensionsValue) {

    if (battleFieldDimensionsValue>1) {

      LOGGER.finest("Received battleFieldDimensionsValue Value Change for battleFieldDimensionsValue !");

      battlefield.dimensions.set(new PVector(battleFieldDimensionsValue, battleFieldDimensionsValue, 0));

      regenerate = true;
    }
  }



  void battleFieldDimensionsforCircleTrench(float battleFieldDimensionsValue) {

    if (battleFieldDimensionsValue>1) {

      LOGGER.finest("Received battleFieldDimensionsValue Value Change for battleFieldDimensionsValue !");

      battlefield.dimensions.set(new PVector(battleFieldDimensionsValue, battleFieldDimensionsValue, 0));

      regenerate = true;
    }
  }  

  void numberOfCircleSegmentsFunction(float segmentNumberToSet) {
    
    LOGGER.info("Number of CircleSegments Slider : "+segmentNumberToSet);
    
    numberOfCircleSegments = (int)segmentNumberToSet;
    
    regenerate = true;
  }
}