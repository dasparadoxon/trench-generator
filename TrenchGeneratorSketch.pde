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

private final Logger LOGGER = Logger.getLogger(getClass().getName() );

TrenchGenerator trenchGenerator;

PeasyCam camera;
ControlP5 cp5;

void setup() {

  setLogger(LOGGER,getClass().getName(),Level.INFO);

  LOGGER.log( Level.INFO, "Setup" );

  size(800, 800, P3D);

  setUpCameraLibrary();

  setUpGUILibrary();

  try {

    trenchGenerator = new TrenchGenerator(camera, cp5, this);
  } 
  catch(Exception exception) {

    LOGGER.log(Level.SEVERE, exception.getMessage()+"\n");

    exit();
  }
}

void draw() {

  LOGGER.finest("Drawing...");

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

  LOGGER.info("Setting up Camera Library...");

  camera = new PeasyCam(this, 0, 0, 0, 500);
}

void setUpGUILibrary() {

  LOGGER.info("Setting up GUI Library...");

  cp5 = new ControlP5(this);
}

// TODO : This has to be put into a base class for all other classes
/*public void setLogger(Logger loggerToSet,String fileName) {

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

  try {
    Handler fileHandler = new FileHandler(sketchPath()+"/log/"+fileName);

    fileHandler.setFormatter(new Formatter() {
      public String format(LogRecord record) {
        return record.getLevel() + "  :  "
          + record.getSourceClassName() + " -:- "
          + record.getSourceMethodName() + " -:- "
          + record.getMessage() + "\n";
      }
    }
    );
    loggerToSet.addHandler(fileHandler);
  }
  catch(Exception exception) {
  }
}*/

// TODO : This has to be put into a base class for all other classes
public void setLogger(Logger loggerToSet,String fileName, Level level) {

  loggerToSet.setUseParentHandlers(false);

  Handler conHdlr = new ConsoleHandler();
  
  conHdlr.setLevel(level);

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

  try {
    Handler fileHandler = new FileHandler(sketchPath()+"/log/"+fileName);
    
    fileHandler.setLevel(level);

    fileHandler.setFormatter(new Formatter() {
      public String format(LogRecord record) {
        return record.getLevel() + "  :  "
          + record.getSourceClassName() + " -:- "
          + record.getSourceMethodName() + " -:- "
          + record.getMessage() + "\n";
      }
    }
    );
    loggerToSet.addHandler(fileHandler);
  }
  catch(Exception exception) {
  }
}