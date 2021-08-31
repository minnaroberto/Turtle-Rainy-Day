// raindrops that are falling over the grassland area, and lands on the grass
class RainLand {   
  float x;  
  float y; 
  float splashY; // point where a raindrop lands on the grass to start a splash
  float speedY;  // speed that the rain moves down
  boolean splash = false;    // determine if a raindrop has splashed  
  boolean resetRain = false; // determine if a raindrop needs to reset its position
  
  RainLand(float randomX, float randomY, float randomSplashY, float randomSpeedY){
    x = randomX;
    y = randomY;
    splashY = randomSplashY;
    speedY = randomSpeedY;
  }
  
  void update(){
    y = y + speedY; // raindrop moves down the canvas
    
    // the raindrop has reached the grass and will splash
    if (y > splashY){
      splash = true;  
    }
  }
  
  //display the rain drops
  void display(){
    stroke(#AFC3CC);
    strokeWeight(2);
    line(x,y,x,y+10);
    
  }
  
  void displaySplash(){
    strokeWeight(2);
    stroke(#AFC3CC);
    
    line(x+5,splashY,x+10,splashY-5); // splash line pointing right
    line(x-5,splashY,x-10,splashY-5); // splash line pointing left

    resetRain = true;
  }

}
