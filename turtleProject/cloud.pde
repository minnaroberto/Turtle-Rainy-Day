class Cloud{
  float y;
  float ySpeed = 0.5;
  float minY;
  float maxY;
  boolean cloudUp;
  boolean cloudDown; 

  void update(){
    // clouds that are moving downwards until their maxY
    if (y < maxY && cloudDown == true){
        y+=ySpeed;
    }
    else {
       cloudDown = false;
       cloudUp = true;
    }
     
    // clouds that are moving upwards until their minY
    if (y > minY && cloudUp == true){
        y-=ySpeed;
    }
    else {
       cloudDown = true;
       cloudUp = false;
    }
  
  }
  
  void displayCloudGroup0(){
    fill(175);
    noStroke();
    
    // light grey clouds that will have the same movement
    ellipse(0,y, 140,115);
    ellipse(100,y, 190,140);
    ellipse(200,y, 140,115);
  
    ellipse(700,y, 140,115);
    ellipse(800,y, 190,140);
    ellipse(900,y, 140,115);
    
  }
  
  void displayCloudGroup1(){
    fill(175);
    noStroke();
    
    // light grey clouds that will have the same movement
    ellipse(350,y, 140,115);
    ellipse(450,y, 190,140);
    ellipse(550,y, 140,115);
    
    ellipse(1050,y, 140,115);
    ellipse(1150,y, 190,140);
    ellipse(1250,y, 140,115);
  }
  
  
  void displayCloudGroup2(){
    fill(160);
    noStroke();
    
    // dark grey clouds that will have the same movement
    ellipse(150,y, 125,100);
    ellipse(250,y, 175,125);
    ellipse(350,y, 125,100);
    
    ellipse(850,y, 125,100);
    ellipse(950,y, 175,125);
    ellipse(1050,y, 125,100);
  }
  
  void displayCloudGroup3(){
    fill(160);
    noStroke();
    
    // dark grey clouds that will have the same movement
    ellipse(500,y, 125,100);
    ellipse(600,y, 175,125);
    ellipse(700,y, 125,100);
  
  }
  
  void displayCloudGroup4(){
    fill(145);
    noStroke();
    
    // dark grey clouds that will have the same movement
    ellipse(0,y, 125,100);
    ellipse(100,y, 175,125);
    ellipse(200,y, 125,100);
    
    ellipse(700,y, 125,100);
    ellipse(800,y, 175,125);
    ellipse(900,y, 125,100);
  
  }
  
  void displayCloudGroup5(){
    fill(145);
    noStroke();
    
    // dark grey clouds that will have the same movement
    ellipse(350,y, 125,100);
    ellipse(450,y, 175,125);
    ellipse(550,y, 125,100);
    
    ellipse(1050,y, 125,100);
    ellipse(1150,y, 175,125);
    ellipse(1250,y, 125,100);
  
  }
  
  
}
