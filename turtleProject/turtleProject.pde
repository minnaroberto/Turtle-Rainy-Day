/*
* Minna Roberto
* Piece Name: Turtle's Rainy Day
* CTCH 204 Final Project
* 
* Code References: 
* Minim Audio Code used from: http://www.cs.cmu.edu/~jar/cn21.pdf
* Used in lines: 20-22 and 49-51
*
* Resources Used:
*   Turtle Image: https://giphy.com/stickers/KellyvillePets-kp-kpets-kellyvillepets-QBeQkMh2isRHa7csKM 
*                  By KellyvillePets on Giphy.com
*
*   Rain Background Audio: https://www.soundjay.com/rain-sound-effect.html
*                Sound file name: Rain Sound Effect 07
*
*/

// minim audio code reference
import ddf.minim.*;
Minim minim;
AudioPlayer player;

PImage[] turtle = new PImage[2];
int turtleImg = 0; // represents which turtle image to display 

RainPond[] rainPond; // rain that will fall into the pond
RainPond[] rainPond2; // another set of rain that will fall into the pond
RainLand[] rainLand; // rain that will fall onto the grass land
RainLand[] rainTree; // rain that will fall onto the tree leaves
ContinuousRain[] rainCont;  // rain that will continue to fall and not ripple or splash
Cloud[] cloud;

float[] grassArrX = new float[500]; // x values for random grass pieces
float[] grassArrY = new float[500]; // y values for random grass pieces

int rainNum = 100;  // amount of rain that will fall onto the pond and grass area
int rainNumCont = 125; // amount of rain that will continue to fall 


void setup(){
  size(1250,900);
  background(255);
  
  turtle[0]= loadImage("turtle1.png");
  turtle[1]= loadImage("turtle2.png");
  
  // minim audio code reference
  minim = new Minim(this);
  player = minim.loadFile("rainBackground.mp3",1024);
  player.loop();  // playing the rain audio on repeat
 

  rainPond = new RainPond[rainNum];  
  // create instances of each pond raindrop 
  for(int i = 0; i<rainPond.length;i++){
    rainPond[i] = new RainPond();
  }
  
  // a second set of pond rain that will fall after the first set reaches the pond
  rainPond2 = new RainPond[30];  
  // create instances of each pond raindrop 
  for(int i = 0; i<rainPond2.length;i++){
    rainPond2[i] = new RainPond();
  }
   
  // create instances of each pond raindrop 
  for(int i = 0; i<rainPond2.length;i++){
    rainPond2[i].y = -175;
  }
  
     
  rainCont = new ContinuousRain[rainNumCont];
  // create instances of each continuously falling raindrop 
  for(int i = 0; i<rainCont.length;i++){
    rainCont[i] = new ContinuousRain();
  }
  

  rainLand = new RainLand[rainNum];
  // create instances of each grass raindrop
  for(int i = 0; i<rainLand.length;i++){
    float randX = random(655, width);  // set a random x value where the raindrop will start falling
    float randY = random(100,500);      // set a random x value where the raindrop will start falling
    float randSplashY = random(500,height);  // set a random point where a raindrop will splash
    float randSpeed = random(20,25);    // set a random speed for the raindrop to fall
    rainLand[i] = new RainLand(randX, randY, randSplashY, randSpeed);
  }
  
  rainTree = new RainLand[10];
  // create instances of each tree raindrop
  for(int i = 0; i<rainTree.length;i++){
    float randX = random(640, 1195);  // set a random x value where the raindrop will start falling
    float randY = random(100,200);    // set a random x value where the raindrop will start falling
    float randSplashY = random(265,450);  // set a random point where a raindrop will splash
    float randSpeed = random(20,25);   // set a random speed for the raindrop to fall
    rainTree[i] = new RainLand(randX, randY, randSplashY, randSpeed);
  }
  

  // set x and y positions of grass pieces that are angled to the right
  for(int i = 0; i<250; i++){
      grassArrX[i] = random(670, width);
      grassArrY[i] = random(505, height);
  }
  
  // set x and y positions of grass pieces that are angled to the left
  for(int i = 250; i<500; i++){
      grassArrX[i] = random(670, width);
      grassArrY[i] = random(505, height);
  }
  
  
  cloud = new Cloud[6];
  // create instances of clouds. There will be 4 cloud groups each with their own
  // set of clouds that will move the same and are shaped the same
  for (int i = 0; i < 6; i++){
    cloud[i] = new Cloud();
  }
  
  // set the initial cloud movement for cloud group 0 and 2
  for (int i = 0; i < 6; i+=2){
    cloud[i].cloudUp = false;
    cloud[i].cloudDown = true;
  }
  
  // set the initial cloud movement for cloud group 1 and 3
  for (int i = 1; i < 6; i+=2){
    cloud[i].cloudUp = true;
    cloud[i].cloudDown = false;
  }
  
  // set the cloud group 0 and cloud group 1 min and max y-values
  for (int i = 0; i < 2; i++){
    cloud[i].minY = 80;
    cloud[i].maxY = 110;
  }
  
  
  // set the cloud group 2 and cloud group 3 min and max y-values
  for (int i = 2; i < 4; i++){
    cloud[i].minY = 65;
    cloud[i].maxY = 90;
  }
  
  // set the cloud group 4 and cloud group 5 min and max y-values
  for (int i = 4; i < 6; i++){
    cloud[i].minY = 55;
    cloud[i].maxY = 75;
  }
  
  // set initial y-values for each cloud group
  cloud[0].y = 80;
  cloud[1].y = 110;
  cloud[2].y = 65;
  cloud[3].y = 85;
  cloud[4].y = 55;
  cloud[5].y = 75;

}

void draw(){
  background(#7A8B8B); // background color set to a light grey
  frameRate(20);
  
  grass();  // call function to display land of grass
  pond();   // call function to display body of pond water
  
  stroke(#059142); // color of green pieces
  // display grass pieces that are angled to the right 
  for(int i = 0; i<250; i++){
      line(grassArrX[i], grassArrY[i],  grassArrX[i]+5,grassArrY[i]-5);
  }
  
  // display grass pieces that are angled to the left
  for(int i = 250; i<500; i++){
      line(grassArrX[i], grassArrY[i],  grassArrX[i]-5,grassArrY[i]-5);
  }
  

  // pond rain travels down from the top of the canvas
  for(int i = 0;i<rainPond.length; i++){
    // the rain hasn't reached the pond yet
    if (rainPond[i].ripple == false){
       rainPond[i].update();
       rainPond[i].display();
    }
    // the rain has reached the pond
    else if (rainPond[i].ripple == true){
       rainPond[i].displayRipple();      // display the raindrop's ripple on the pond
    }
  }
  
  // second set of pond rain travels down from the top of the canvas
  for(int i = 0;i<rainPond2.length; i++){
    // the rain hasn't reached the pond yet
    if (rainPond2[i].ripple == false){
       rainPond2[i].update();
       rainPond2[i].display();
    }
    // the rain has reached the pond
    else if (rainPond2[i].ripple == true){
       rainPond2[i].displayRipple();      // display the raindrop's ripple on the pond
    }
  }
  
  // pond rain resets to the top of the canvas
  for(int i = 0; i<rainPond.length; i++){
    // the ripple has reached its max diameter 
    if(rainPond[i].rippleMax1 == true && rainPond[i].rippleMax2 == true && rainPond[i].rippleMax3 == true){
        rainPond[i].x = random(10,600);  // set a new x position for the raindrop
        rainPond[i].y = 100;             // set a new y position for the raindrop
        rainPond[i].ripple = false;      // the ripple has stopped so reset to false
        rainPond[i].rippleMax1 = false;   // the ripple's max diameter has been reached so reset to false
        rainPond[i].rippleMax2 = false;  // the ripple's max diameter has been reached so reset to false
        rainPond[i].rippleMax3 = false;  // the ripple's max diameter has been reached so reset to false
        rainPond[i].ellipseSize2 = -10;     // reset the ripple's starting dimensions
        rainPond[i].ellipseSize3 = -20;    // reset the ripple's starting dimensions
          
    }
  }
  
  // pond rain resets to the top of the canvas
  for(int i = 0; i<rainPond2.length; i++){
    // the ripple has reached its max diameter 
    if(rainPond2[i].rippleMax1 == true && rainPond2[i].rippleMax2 == true && rainPond2[i].rippleMax3 == true){
        rainPond2[i].x = random(10,600);  // set a new x position for the raindrop
        rainPond2[i].y = -50;             // set a new y position for the raindrop
        rainPond2[i].ripple = false;      // the ripple has stopped so reset to false
        rainPond2[i].rippleMax1 = false;   // the ripple's max diameter has been reached so reset to false
        rainPond2[i].rippleMax2 = false;  // the ripple's max diameter has been reached so reset to false
        rainPond2[i].rippleMax3 = false;  // the ripple's max diameter has been reached so reset to false
        rainPond2[i].ellipseSize2 = -10;     // reset the ripple's starting dimensions
        rainPond2[i].ellipseSize3 = -20;    // reset the ripple's starting dimensions
          
    }
  }
  
  // rain above grass travels down from the top of the canvas
  for(int i = 0;i<rainLand.length; i++){
    // the rain hasn't reached the grass yet
    if (rainLand[i].splash == false){
       rainLand[i].update();
       rainLand[i].display();
     }
    // the rain has reached the grass
    else if (rainLand[i].splash == true){
       rainLand[i].displaySplash();  // display the raindrop's splash 
    }
  }
  
  // rain that reached the grass will reset the x and y coordinates
  for(int i = 0; i<rainLand.length; i++){
    if(rainLand[i].resetRain == true){
        rainLand[i].x = random(655,width);   // set a new x position for the raindrop
        rainLand[i].y = 100;                 // set a new y position for the raindrop
        rainLand[i].splash = false;          // the raindrop has splashed so reset to false
        rainLand[i].resetRain = false;       // the raindrop's has new positions, so reset to false
    }
  }
  
  tree(); // call function to display the trees
  
  // rain above tree travels down from the top of the canvas
  for(int i = 0;i<rainTree.length; i++){
    // the rain hasn't reached the grass yet
    if (rainTree[i].splash == false){
       rainTree[i].update();
       rainTree[i].display();
     }
    // the rain has reached the grass
    else if (rainTree[i].splash == true){
       rainTree[i].displaySplash();  // display the raindrop's splash 
    }
  }
  
  // rain that reached the tree leaves will reset the x and y coordinates
  for(int i = 0; i<rainTree.length; i++){
    if(rainTree[i].resetRain == true){
        rainTree[i].x = random(640, 1195);  // set a new x position for the raindrop
        rainTree[i].y = 100;                 // set a new y position for the raindrop
        rainTree[i].splash = false;          // the raindrop has splashed so reset to false
        rainTree[i].resetRain = false;       // the raindrop's has new positions, so reset to false
    }
  }
   
  //determine the turtle image to display depending on the frameCount
  if (frameCount%9 == 0){
    turtleImg = 0;
  }
  else if (frameCount%25 == 0) {
    turtleImg = 1;
  }
  image(turtle[turtleImg], 823,650, 190,190); // display the turtle image


  // display continuous rain
  for(int i = 0;i<rainCont.length; i++){
    if (rainCont[i].resetRain == false){
       rainCont[i].update();
       rainCont[i].display();     
    }
  }
  
  // continuous rain resets to the top of the canvas
  for(int i = 0; i<rainCont.length; i++){
    if(rainCont[i].resetRain == true){
        rainCont[i].x = random(10,width);  // reset a new x position for the raindrop
        rainCont[i].y = 100;               // reset a new y position for the raindrop 
        rainCont[i].resetRain = false;               
    }
  }
  

  
  fill(130);
  // dark grey background behind the clouds
  beginShape();
  vertex(0,0);
  vertex(width,0);
  vertex(width, 100);
  vertex(0,100);
  endShape();
  
  // display the furthest dark grey clouds
  cloud[4].update();
  cloud[4].displayCloudGroup4();
  cloud[5].update();
  cloud[5].displayCloudGroup5();
  
  // dark grey clouds behind the light grey clouds
  cloud[2].update();
  cloud[2].displayCloudGroup2();
  cloud[3].update();
  cloud[3].displayCloudGroup3();

  // light grey clouds in front of the dark grey clouds
  cloud[0].update();
  cloud[0].displayCloudGroup0();
  cloud[1].update();
  cloud[1].displayCloudGroup1();
  
}


void grass(){
  noStroke();
  fill(#19A32A);
  
  beginShape();
  vertex(width/2, 500);
  vertex(width,500);
  vertex(width,height);
  vertex(width/2,height);
  endShape();
  
}


void pond(){
  noStroke();
  ellipseMode(CENTER);
  fill(#0077BE);
  
  // pond water area
  beginShape();
  vertex(width/2, 500);
  vertex(width/2, height);
  vertex(0,height);
  vertex(0,500);
  endShape();
  
  ellipse(622,738, 60, 475); // ellipse to represent the right side curve of the pond 
}

void tree(){
  noStroke();
  rectMode(CENTER);
  
  // tree to the left
  fill(#613B16); 
  // brown tree trunk  
  rect(800,550, 80,200);
  beginShape();
  vertex(760,650);
  vertex(840, 650);
  vertex(860, 675);
  vertex(740,675);
  endShape();

  fill(#054907); 
  // darker green ellipses for leaves in the back of tree
  ellipse(740,430,75,75);
  ellipse(690,405,75,75);
  ellipse(660,350,75,75);
  ellipse(675,350,75,75);
  ellipse(685,300,75,75);
  ellipse(730,280,75,75);
  ellipse(815,265,75,75);
   
  fill(#0b5509);
  // green ellipses to make the front leaves of tree 
  ellipse(800,350,200,200);
  ellipse(710,395,75,75);
  ellipse(750,425,75,75);
  ellipse(800,440,75,75);
  ellipse(860,425,75,75);
  ellipse(680,350,75,75);
  ellipse(705,295,75,75);
  ellipse(835,270,75,75);
  ellipse(770,270,75,75);
  
  stroke(#432702);
  // lines on the tree trunk
  line(775, 475, 775, 515);
  line(800, 490, 800, 540);
  line(825,480, 825, 500);
  
  line(775, 550, 775, 580);
  line(800, 560, 800, 585);
  line(825, 525, 825, 560);
  
  line(775, 600, 775, 620);
  line(800, 600, 800, 635);
  line(825, 575, 825, 625);
  
  // tree to the right
  noStroke();
  fill(#613B16); 
  // brown tree trunk
  rect(1100, 540, 80,185);
  beginShape();
  vertex(1060,630);
  vertex(1140,630);
  vertex(1160,660);
  vertex(1040,660);
  endShape();

  fill(#054907); 
  // darker green ellipses for leaves in the back of tree
  ellipse(1165,430,75,75);
  ellipse(1195,420,75,75);
  ellipse(1210,390,75,75);
  ellipse(1210,350,75,75);
  ellipse(1205,295,75,75);
  ellipse(1170,275,75,75);
  ellipse(1100,265,75,75);

  
  fill(#0b5509);
  // green ellipses to make the front leaves of tree 
  ellipse(1100,360,200,200);
  ellipse(1100,430,75,75);
  ellipse(1150,420,75,75);
  ellipse(1190,400,75,75);
  ellipse(1195,350,75,75);
  ellipse(1185,295,75,75);
  ellipse(1130,275,75,75);
  ellipse(1055,275,75,75);
  
  stroke(#432702);
  // lines on the tree trunk
  line(1075,480, 1075, 495);
  line(1100, 490, 1100, 550);
  line(1125,475, 1125, 500);
  
  line(1075,510, 1075, 570);
  line(1100, 565, 1100, 575);
  line(1125, 525, 1125, 550);
    
  line(1075, 595, 1075, 625);
  line(1100, 600, 1100, 620);
  line(1125, 575, 1125, 600);
  
  
  // middle tree that turtle is under
  noStroke();
  fill(#613B16); 
  // brown tree trunk
  rect(950,575, 95,400);
  beginShape();
  vertex(902.5,775);
  vertex(997.5,775);
  vertex(1017,800);
  vertex(882.5,800);
  endShape();

  fill(#054907); 
  // darker green ellipses for leaves in the back of tree
  ellipse(885,430,100,100);
  ellipse(830,400,100,100);
  ellipse(800,345,100,100);
  ellipse(820,345,100,100);
  ellipse(830,295,100,100);
  ellipse(875,275,100,100);
  
  ellipse(1025,430,100,100);
  ellipse(1060,420,100,100);
  ellipse(1085,390,100,100);
  ellipse(1110,350,100,100);
  ellipse(1085,295,100,100);
  ellipse(1035,275,100,100);
  ellipse(965,260,100,100);

  
  fill(#0b5509);
  // green ellipses to make the front leaves of tree 
  ellipse(950,350,250,250);
  ellipse(860,395,100,100);
  ellipse(900,425,100,100);
  ellipse(950,440,100,100);
  ellipse(1010,425,100,100);
  ellipse(1050,400,100,100);
  ellipse(830,350,100,100);
  ellipse(1080,350,100,100);
  ellipse(1060,295,100,100);
  ellipse(850,295,100,100);
  ellipse(990,260,100,100);
  ellipse(915,260,100,100);
  
  stroke(#432702);
  // lines on the tree trunk
  line(925, 500, 925, 545);
  line(950, 525, 950, 570);
  line(975,500, 975, 545);
  
  line(925,575, 925, 610);
  line(950, 600, 950, 640);
  line(975, 580, 975, 600);
  
    
  line(925, 640, 925, 680);
  line(950, 670, 950, 685);
  line(975, 630, 975, 695);
  
  line(925, 700, 925, 715);
  line(950, 705, 950, 730);
  line(975, 715, 975, 725);

}
