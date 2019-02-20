boolean vfProcessing;

void setup() {
  size(100,100);
  frameRate(10);
  vfProcessing = false;
  noLoop();
}

void draw() {
  
  if(!vfProcessing) {
    vfProcessing = true;
    for(int viLoop = 0; viLoop < 10; viLoop++) {
    
      print("c");
      break;
      
    }
    reDraw();
  }
}
