/*************************************************************************************
 * WW1 TRENCH GENERATOR
 * 
 * Creates a trench which parameters can be live changed and exportet to XML 
 * for use in other programms
 * 
 *************************************************************************************/
import controlP5.*;
import peasy.*;
import java.util.logging.*;

private final Logger LOGGER = Logger.getLogger( "MAIN" );

TrenchGenerator trenchGenerator;


PeasyCam camera;
ControlP5 cp5;

void setup() {

  //print(LOGGER.getHandlers());

  //System.out.println(Arrays.toStringLOGGER.getHandlers());

  //print(LOGGER.getHandlers().length);


  /*Handler cH = new ConsoleHandler();
   
   LOGGER.setUseParentHandlers(false);
   
   LOGGER.setLevel(Level.INFO);
   
   LOGGER.addHandler(cH);*/

  setLogger(LOGGER);

  LOGGER.log( Level.INFO, "Setup" );

  size(800, 800, P3D);

  setUpCameraLibrary();

  setUpGUILibrary();

  trenchGenerator = new TrenchGenerator(camera, cp5, this);
}

void draw() {

  try {

    trenchGenerator.draw();
  } 
  catch(Exception exception) {

    print(exception.getMessage()+"\n");
    exception.printStackTrace();
    exit();
  }
}

void setUpCameraLibrary() {

  camera = new PeasyCam(this, 0, 0, 0, 500);
}

void setUpGUILibrary() {

  cp5 = new ControlP5(this);
}

public void setLogger(Logger loggerToSet) {

  loggerToSet.setUseParentHandlers(false);
  Handler conHdlr = new ConsoleHandler();

  conHdlr.setFormatter(new Formatter() {
    public String format(LogRecord record) {
      return record.getLevel() + "  :  "
        + record.getSourceClassName() + " -:- "
        + record.getSourceMethodName() + " -:- "
        + record.getMessage() + "\n";
    }
  }
  );
  loggerToSet.addHandler(conHdlr);
}