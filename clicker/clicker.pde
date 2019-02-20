/*
  Stick Defence Clicker
  
  http://www.crazygames.com/game/stick-defense
  
  http://www.officegamespot.com/action/storm_the_house_3.htm
  
  MRB 16/02/19
 */
 
import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.AWTException;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
 
PImage screenshot;
Rectangle dimension;
Robot robot;

int vWidth = 0;
int vHeight = 0;
int viCount = 0;
int viCount2 = 0;
int vXOffset = 0;
int vYOffset = 0;

boolean vfProcessing = true;
boolean vfReposition;

void setup() {
  
  vXOffset = 5;
  vYOffset = 200;
  
  size(683,500); //<>//

  frameRate(5);
 
  colorMode(RGB);
  imageMode(CORNER);
  background((color) random(#000000));

  vWidth = displayWidth / 2;
  vHeight = displayHeight; 
  screenshot = createImage(vWidth, vHeight, ARGB);
  dimension  = new Rectangle(vWidth, vHeight);
  
  vfReposition = false;
  
  try {
    robot = new Robot();
  }
  catch (AWTException cause) {
    println(cause);
    exit();
  }
  
  vfProcessing = false;
}
 
void draw() {
  
  if(!vfReposition) {
    getSurface().setLocation(683,0);
    vfReposition = true;
  }
  
 // print("Call to draw " + vfProcessing + "\n");

  if(vfProcessing == false) {
    noLoop();
    vfProcessing = true;
    
    PImage vScreenShot = grabScreenshot(screenshot, dimension, robot);
    
    //for(int viLoop = 0; viLoop < (vScreenShot.pixels.length - 1); viLoop+=2) {
    //    int vX = viLoop % vScreenShot.width;
    //    int vY = viLoop / vScreenShot.width;
 /*   
    print("w" + vScreenShot.width + "\n");
    print("h" + vScreenShot.height + "\n");
    print("l" + vScreenShot.pixels.length + "\n");
    print("*" + ( vScreenShot.width * vScreenShot.height ) + "\n");
 */   
    // Start bottom right and work up to top of screen then left 1 row then up again etc...
    for(int vX = vScreenShot.width; vX > 0; vX--) {
      for(int vY = vScreenShot.height; vY > 0; vY --) {
        
        int viLoop = (( vX * vScreenShot.width ) + vY ) - 1;
        if( vScreenShot.pixels[viLoop] == -13158601 ) { // Gone back to menu so exit
            print("Back on menu, exit! " + vfProcessing + "\n");
            exit();
            break;
        }  
      
        if( vScreenShot.pixels[viLoop] == -16777216 ){
            
          vScreenShot.pixels[viLoop] = -1;
          vScreenShot.pixels[viLoop + 1] = -1;
            
          robot.mouseMove(vY + vXOffset,vX + vYOffset);
           
          robot.mousePress( InputEvent.BUTTON1_MASK );
          robot.mouseRelease( InputEvent.BUTTON1_MASK );
  
          print("Shot! " + viCount + " --> " + viCount2 + " @ : " + (vX + vXOffset) + ":" + (vY + vYOffset) + "\n");
          
          viCount++;  
          
          if(viCount >= 6) {
            viCount = 0;
            print("Reload!\n");
            robot.keyPress(KeyEvent.VK_SPACE);
            viCount2++;
          }
          
          if(viCount2 >= 500) { // 10 reloads, exit
            exit();
            break;
          }
  
          break; // found one quit
        }
      }
    } 
    image(vScreenShot, 0, 0, vWidth, vHeight);
    loop();
    vfProcessing = false;
  }
  
 
}
 
static final PImage grabScreenshot(PImage pImg, Rectangle pDim, Robot pBot) {
  //return new PImage(bot.createScreenCapture(dim));
  
  pBot.createScreenCapture(pDim).getRGB(
    5, 
    200, 
    pDim.width - 130, 
    300, 
    pImg.pixels, 
    0, 
    pDim.width);
 
  pImg.updatePixels();
    
  return pImg;
}
