// raindrops that are falling over the pond area, and lands on the pond
class RainPond {
  float x = random(10, 600);        // set a random x value where the raindrop will start falling
  float y = random(100,500);        // set a random x value where the raindrop will start falling
  float speedY = random(20,30);     // set a random speed for the raindrop to fall
  float ellipseSize = 0;            // starting size of the ellipse ripple (outer ripple)
  float ellipseSize2 = -10;         // starting size of the ellipse ripple (middle ripple)
  float ellipseSize3 = -20;         // starting size of the ellipse ripple (inner ripple)
  float maxEllipseSize = 40;        // maximum diameter of the ellipse ripple
  float rippleY = random(525,height); //point where a rain drop lands on the water to start a ripple
  boolean ripple = false;           // determine if a ripple is formed 
  boolean rippleMax1 = false;        // determine if the ripple1 (outer ripple) has reached its max diameter
  boolean rippleMax2 = false;       // determine if the ripple2 (middle ripple) has reached its max diameter
  boolean rippleMax3 = false;       // determine if the ripple3 (inner ripple) has reached its max diameter
  boolean resetRain = false;        // determine if a raindrop needs to reset its position
  
  void update(){
    y = y + speedY;   // raindrop moves down the canvas
    
    // the raindrop reaches its point on the water to begin a ripple
    if (y > rippleY){
      ripple = true;  
    }
  }
  
  //display the rain drops
  void display(){
    stroke(#AFC3CC);
    strokeWeight(2);
    line(x,y,x,y+10);
  }


  void displayRipple(){
    ellipseMode(CENTER);
    strokeWeight(0.5);
    stroke(#AFC3CC);
    noFill();
   
    // ripple has not reached its max diameter
    if(ellipseSize < maxEllipseSize && rippleMax1 == false){
      ellipseSize++;  
      ellipse(x, rippleY, ellipseSize, ellipseSize);
    }
    else {
      ellipseSize = 0;  // reset the ellipseSize    
      rippleMax1 = true;
    }
    
    // ripple2 has not reached its max diameter
    if(ellipseSize2 < maxEllipseSize  && rippleMax2 == false){
      ellipseSize2++;  
      ellipse(x, rippleY, ellipseSize2, ellipseSize2);
    }
    else {
      ellipseSize2 = 0;  // reset the ellipseSize
      rippleMax2 = true;
    }
    
    // ripple3 has not reached its max diameter
    if(ellipseSize3 < maxEllipseSize  && rippleMax3 == false){
      ellipseSize3++;  
      ellipse(x, rippleY, ellipseSize3, ellipseSize3); 
    }
    else {
      ellipseSize3 = 0;  // reset the ellipseSize  
      rippleMax3 = true;
    }
  }
  
}
