/* 
*  continuous rain was created because there were gaps where rain wouldn't fall during ripples. 
*  This rain is used to fill in those gaps.
*/
class ContinuousRain {
  float x = random(10, width);          // set a random x value where the raindrop will start falling
  float y = random(200,500);            // set a random x value where the raindrop will start falling
  float speedY = random(20,25);         // speed that the rain moves down
  float dropPointY = random(575,height);//point where a raindrop will land 
  boolean resetRain = false;            // determine if a raindrop needs to reset its position
  
  void update(){
    y = y + speedY;  // raindrop moves down the canvas
    
    if (y > dropPointY){
      resetRain = true;  // the raindrop has reached its landing position and will reset its new position
    }
  }
  
  //display the rain drops
  void display(){
    stroke(#AFC3CC);
    strokeWeight(2);
    line(x,y,x,y+10);
  }

}
