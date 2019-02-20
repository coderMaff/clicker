/*
  Stick Defence Clicker - using https://Processing.org
    
  http://www.officegamespot.com/action/storm_the_house_3.htm
  
  MRB 16/02/19  Created
  MRB 20/02/19  Shoot everything, 1 shot per 100ms, don't shoot twice in same spot, bigger find target box, offset shooting 
 */
 
import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.AWTException;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import java.util.GregorianCalendar;
 
PImage screenshot;
Rectangle dimension;
Robot robot;

int vWidth = 0;
int vHeight = 0;
int viCount = 0;
int viCount2 = 0;
int vXOffset = 0;
int vYOffset = 0;
GregorianCalendar gcNow, gcBefore;
int vLastShot;

boolean vfProcessing = true;
boolean vfReposition;

void setup() {
  
  gcBefore = new GregorianCalendar();
  
  vXOffset = 5;
  vYOffset = 220;
  
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
 
  fnProcess();
}

void fnProcess() {
 // print("Call to draw " + vfProcessing + "\n");

  
  if(vfProcessing == false) {
    noLoop();
    vfProcessing = true;
    
    PImage vScreenShot = grabScreenshot(screenshot, dimension, robot);
    
    for(int viLoop = 0; viLoop < (vScreenShot.pixels.length - 1); viLoop+=2) {
        int vX = viLoop % vScreenShot.width;
        int vY = viLoop / vScreenShot.height;
  
        if( vScreenShot.pixels[viLoop] == -13158601 ) { // Gone back to menu so exit
            print("Back on menu, exit! " + vfProcessing + "\n");
            exit();
            break;
        }  
      
        if(
            ( vScreenShot.pixels[viLoop] == -16777216 ) &&
            ( vScreenShot.pixels[viLoop + 1] == -16777216 ) &&
            ( vScreenShot.pixels[viLoop + 2] == -16777216 ) &&
            ( vScreenShot.pixels[viLoop + vScreenShot.width] == -16777216 ) &&
            ( vScreenShot.pixels[viLoop + (vScreenShot.width * 2)] == -16777216 ) &&
            ( vScreenShot.pixels[viLoop + (vScreenShot.width * 3)] == -16777216 ) &&
            ( vScreenShot.pixels[viLoop + (vScreenShot.width * 4)] == -16777216 ) &&
            ( vScreenShot.pixels[viLoop + (vScreenShot.width * 5)] == -16777216 ) &&
            ( vScreenShot.pixels[viLoop + (vScreenShot.width * 6)] == -16777216 ) &&
            ( vScreenShot.pixels[viLoop + (vScreenShot.width * 7)] == -16777216 ) &&              
            ( vScreenShot.pixels[viLoop + (vScreenShot.width * 8)] == -16777216 ) &&
            ( vScreenShot.pixels[viLoop + (vScreenShot.width * 9)] == -16777216 ) &&             
            ( vScreenShot.pixels[viLoop + (vScreenShot.width * 10)] == -16777216 ) &&
            ( vScreenShot.pixels[viLoop + (vScreenShot.width * 11)] == -16777216 ) &&            
            ( vScreenShot.pixels[viLoop + (vScreenShot.width * 12)] == -16777216 ) &&
            ( vScreenShot.pixels[viLoop + (vScreenShot.width * 13)] == -16777216 ) &&            
            ( vScreenShot.pixels[viLoop + (vScreenShot.width * 14)] == -16777216 ) 

          ) {
            
          // Don't shoot twice in the same place
          if((viLoop > vLastShot) && (viLoop < vLastShot + 5)) break;          
          vLastShot = viLoop; 
          
          vScreenShot.pixels[viLoop] = -1;
          vScreenShot.pixels[viLoop + 1] = -1;
          vScreenShot.pixels[viLoop + 2] = -1;
          vScreenShot.pixels[viLoop + vScreenShot.width] = -1;
          vScreenShot.pixels[viLoop + (vScreenShot.width * 2)] = -1;
          vScreenShot.pixels[viLoop + (vScreenShot.width * 3)] = -1;
          vScreenShot.pixels[viLoop + (vScreenShot.width * 4)] = -1;
          vScreenShot.pixels[viLoop + (vScreenShot.width * 5)] = -1;
          vScreenShot.pixels[viLoop + (vScreenShot.width * 6)] = -1;
          vScreenShot.pixels[viLoop + (vScreenShot.width * 7)] = -1;
          vScreenShot.pixels[viLoop + (vScreenShot.width * 8)] = -1;
          vScreenShot.pixels[viLoop + (vScreenShot.width * 9)] = -1;
          vScreenShot.pixels[viLoop + (vScreenShot.width * 10)] = -1;
          vScreenShot.pixels[viLoop + (vScreenShot.width * 11)] = -1;          
          vScreenShot.pixels[viLoop + (vScreenShot.width * 12)] = -1;
          vScreenShot.pixels[viLoop + (vScreenShot.width * 13)] = -1;
          vScreenShot.pixels[viLoop + (vScreenShot.width * 14)] = -1;
             
           
          gcNow = new GregorianCalendar();
          
          if((gcNow.getTimeInMillis() - gcBefore.getTimeInMillis()) > 100) {
            
            robot.mouseMove(vX + vXOffset + 1,vY + vYOffset + 12);
            
            robot.mousePress( InputEvent.BUTTON1_MASK );
            robot.mouseRelease( InputEvent.BUTTON1_MASK );
            gcBefore = new GregorianCalendar();
           
            print("Shot! " + viCount + " --> " + viCount2 + " @ : " + (vX + vXOffset) + ":" + (vY + vYOffset) + "\n");
            
            viCount++;  
            
            if(viCount >= 7) {
              viCount = 0;
              print("Reload!\n");
              robot.keyPress(KeyEvent.VK_SPACE);
              viCount2++;
            }
            
            if(viCount2 >= 50) { // 10 reloads, exit
              exit();
              break;
            }
          }
       //   break; // found one quit
        }
  //    }
  //    if(vfBreak) break;
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
