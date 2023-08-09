//variables 
int Xcamera;
int frame, fakeFrame;
int gameStatus = 0;

//time
int interval = 1000;
String time = "000";
int initialTime;
int tick = 0;

//mouse movements boolean 
boolean left = false;
boolean right = false;
boolean space = false;
boolean noMove = true;
boolean leftSide, rightSide;
boolean lose;
//background variables 
PImage background1;
PImage background2;
PImage background3;

//player movements
PImage [] moveRight,moveLeft,jumpLeft,jumpRight,idleRight,idleLeft;


//player x and y 
int xPlayer= 0;
int yPlayer = 140;
int y1 = 140;




//Frames
int playerFrames,number;

//moving background variables 
int movingBg1, movingBg2, movingBg3;

//classes
Collision[] block;

void setup()
{
  size(800,300);
  frame = 0;
  playerFrames = 6;
  frameRate(18);
  movingBg1 = 0;
  movingBg2 = 0;
  movingBg3 = 0;
  
  right = true;
  lose = false;

  background1 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_1_sm.png");
  background1.resize(800,300);
  
  background2 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_2_sm.png");
  background2.resize(800,300);
  
  background3 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_3_sm.png");
  background3.resize(800,300);
  
  moveRight = move(loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/run_r.png"));
  moveLeft = move(loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/run_l.png"));
  jumpLeft = move(loadImage("C:/Users/rache/OneDrive/Desktop/Uni/TRI 2/151/A3/Parallax_side_scroller/character/jump_l.png"));
  jumpRight = move(loadImage("C:/Users/rache/OneDrive/Desktop/Uni/TRI 2/151/A3/Parallax_side_scroller/character/jump_r.png"));
  idleRight = move(loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/idle_r.png"));
  idleLeft = move(loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/idle_l.png"));
  
  
  
  block = new Collision[1];
  for(int i = 0; i < block.length; i++)
    {
    block[i] = new Collision();
    }
}

void draw()
{
  if(tick != 30){
    if (millis() - initialTime > interval)
    {
    time = nf(int(millis()/1000), 3);
    initialTime = millis();
    tick ++;
    } 
    if(gameStatus == 0)
      {
      drawParallax();
      update();
      frame++;
      for(int i = 0; i < block.length; i++)
        {
        block[i].displayBlock();
        if(block[i].hit())
          {
          block[i] = new Collision();
          gameStatus = 1;
          }
        else{gameStatus = 0;}
        }
      }
    else{fill(0); textSize(44); text("Game Over!!", 250,160);}
  }else{fill(0);textSize(44);text("Times Up", 250,160);}
  
  fill(0); 
  textSize(30);
  text(time,720,40);
}


int world2Screen(int x, int y, int z, int imgW)
{
  int temp = (x -  Xcamera)/z+y;
  if(temp <= -imgW)
  {
    temp = imgW;
    Xcamera = 0 ;
  }
  return temp;
}


//images of the backgound and player

void drawParallax()
{
   if (!noMove) {
     if(left) {Xcamera -= 1;}
     if (right) {Xcamera ++;}
     if (Xcamera > 0) {
        movingBg1 = world2Screen(-1,0,3,background1.width)+background1.width;
        movingBg2 = world2Screen(-1,0,2,background2.width)+background1.width;
        movingBg3 = world2Screen(-1,0,1,background3.width)+background1.width;
       if(xPlayer > (width*80/100)){xPlayer = (width*80/100);}
       }
     if (Xcamera < width)
     {
        movingBg1 = world2Screen(-1,0,3,background1.width)-background1.width;
        movingBg2 = world2Screen(-1,0,2,background2.width)-background1.width;
        movingBg3 = world2Screen(-1,0,1,background3.width)-background1.width;
     }
   }

  image(background1, movingBg1,0);
  image(background1, movingBg1+background1.width,0);
  image(background1, movingBg1+(2*background1.width),0);

  image(background2, movingBg2,0);
  image(background2, movingBg2+background2.width,0);
  image(background2, movingBg2+(2*background1.width),0);

  image(background3, movingBg3,0);
  image(background3, movingBg3+background3.width,0);
  image(background3, movingBg3+(2*background1.width),0);
}

//key and player movements
PImage[] move(PImage movement)
{
  int playerFrames = movement.width/56;
  PImage[] playerImage = new PImage[playerFrames];
  for(int i = 0; i< playerFrames; i++)
  {
    playerImage[i] = movement.get(i*56,0,movement.width/playerFrames,56);
    playerImage[i].resize(140,140);
  }
  return playerImage;
}

//physic of the players movements
void update()
{
    if(right && !noMove && !space)
    {

     image(moveRight[frame%moveRight.length], xPlayer, yPlayer);
     if(xPlayer < width * 0.75){xPlayer += 5;}
 
    }
    if(right && noMove && !space){image(idleRight[frame%idleRight.length], xPlayer, yPlayer);}

    if(left && !noMove && !space)
    {
      
        image(moveLeft[frame%moveLeft.length], xPlayer, yPlayer);
        if(xPlayer > width * 0.1 || xPlayer > 0){xPlayer -= 5;}
      
    }
    if(left && noMove && !space){image(idleLeft[frame%idleLeft.length], xPlayer, yPlayer);}
    
    //jump
    if(left && !noMove && space)
    {
      image(jumpLeft[fakeFrame%jumpLeft.length], xPlayer+10, yPlayer-25);
      if(xPlayer > width * 0.1 || xPlayer > 0){xPlayer -= 5;}
      y1 -= 50;
      fakeFrame++;
      if(fakeFrame == 10){space = false;y1 -= 50;}
    }
     if(right && !noMove && space)
    {
     image(jumpRight[fakeFrame%jumpRight.length], xPlayer+10, yPlayer-25);
     if(xPlayer < width * 0.75 ){xPlayer += 5;}
     y1 -= 50;
     fakeFrame++;
     if(fakeFrame == 10){space = false;y1 -= 50;}
    }
    //jump if player is still
    if(right && space && noMove)
    {
      image(jumpRight[fakeFrame%jumpRight.length], xPlayer, yPlayer-25);
      y1 -= 50;
      fakeFrame++;
      if(fakeFrame == 10){space = false;y1 -= 50;}
    }
    if(left && space && noMove)
    {
      image(jumpLeft[fakeFrame%jumpLeft.length], xPlayer, yPlayer-25);
      y1 -= 50;
      fakeFrame++;
      if(fakeFrame == 10){space = false;y1 -= 50;}
    }
}

//key pressed and released by user
void keyPressed()
{
  if(key == 'd')
  {
   right = true;
   noMove = false;
   left = false;
  }
  else if(key == 'a')
  {
    left = true;
    noMove = false;
    right = false;
  }
  else if(key == ' ')
  {
   space = true;
   fakeFrame = 0;
  }
}

void keyReleased()
{
  if(key == 'd' && right == true)
  {
   noMove = true;
  }
  if(key == 'a' && left == true)
  {
    noMove = true;
  }
 if(key == 'd' && left == true)
  {
    right = false;
  }
  if(key == 'a' && right == true)
  {
    left = false;
  }
}
