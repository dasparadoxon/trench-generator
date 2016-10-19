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

  setLogger(LOGGER, getClass().getName(), Level.INFO);

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

  //exit();
}

void setUpCameraLibrary() {

  LOGGER.info("Setting up Camera Library...");

  camera = new PeasyCam(this, 0, 0, 0, 500);
}

void setUpGUILibrary() {

  LOGGER.info("Setting up GUI Library...");

  cp5 = new ControlP5(this);
}

public void setLogger(Logger loggerToSet, String fileName, Level levelToSet) {

  loggerToSet.setUseParentHandlers(false);

  Handler[] handlers = loggerToSet.getHandlers();

  LOGGER.fine("Setting Logger :"+loggerToSet.getName()+" L: "+levelToSet.toString()+" | "+handlers.length+" Handlers.");

  if (handlers.length == 0) {

    Handler conHdlr = new ConsoleHandler();

    conHdlr.setLevel(levelToSet);

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

      fileHandler.setLevel(levelToSet);

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

  loggerToSet.setLevel(levelToSet);
}

void controlEvent(ControlEvent theEvent) {
    
    LOGGER.info("Drop Down Event");
    // DropdownList is of type ControlGroup.
    // A controlEvent will be triggered from inside the ControlGroup class.
    // therefore you need to check the originator of the Event with
    // if (theEvent.isGroup())
    // to avoid an error message thrown by controlP5.

    if (theEvent.isGroup()) {
      
      //println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
    } else if (theEvent.isController()) {
      
      LOGGER.finest("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController().getName());

      if(theEvent.getController().getName()=="modeDropDownFunction"){
      
        if (theEvent.getController().getValue() == 0)
          trenchGenerator.setShapeMode(LINEMODE);
  
  
        if (theEvent.getController().getValue() == 1)
         trenchGenerator.setShapeMode(CIRCLEMODE);
         
      }
    }
  }