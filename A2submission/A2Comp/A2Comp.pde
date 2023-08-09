//Ball 
int vx = 2; 
int vy = 4;
float xB = 120, yB = 220 ;
int r = 12; 

//Bat
int batY = 330;
int batHeight = 15;
int batWidth = 60; 

//Brick
int brickHeight = 20;
int brickWidth = 100; 
int rows = 3;
boolean hit = false;
Brick[][] bricks = new Brick[10][10];

void setup(){
  size(500, 390);
   for (int i =0; i < rows; i++) {
    for (int j = 0; j < width/brickWidth; j++) {
     bricks[i][j] = new Brick(0, i, j); // create list of bricks with 0 hits
     bricks[i][j].display();
    }
  }
}

void draw(){
  background(0);
  fill(255);
  noStroke();
  ellipse(xB, yB, 2*r, 2*r);  //ball
  rect(mouseX-batWidth/2, batY, batWidth, batHeight); //bat
  moveBall();
  
  hit = false;
  for (int i =0; i < rows; i++) {
    for (int j = 0; j < width/brickWidth; j++) {
      bricks[i][j].brickCollision();
      bricks[i][j].display();
      }
  }
}

void moveBall(){
   xB += vx; 
   yB += vy;
   
   // Ball bounces off walls
   if (xB+r > width || xB-r<0){ vx = -vx; }
   if (yB+r > height|| yB-r<0){ vy = -vy; } 
  
   // Check ball on each side of bat
   if (yB+r/2 > batY && yB-r/2<batY+batHeight && xB>mouseX-batWidth && xB<mouseX + batWidth){
     vy = -vy; 
   }
   if (xB-r/2<mouseX+batWidth/2 && xB+r/2>mouseX-batWidth/2 && yB>batY && yB<batY+batHeight){
     vx = -vx; 
  }
}

public class Brick {
  int hitNum;
  int row, col;
  int x, y, brickR, brickB; //left, top, right, bottom 

  //Constructer
  public Brick(int hitNum, int row, int column) {
    this.col = column;
    this.row = row;
    this.hitNum = hitNum;
   
    // dimensions
    this.x = (this.col * brickWidth) + 1;
    this.brickR = this.x + brickWidth - 2;
    this.y = (this.row * brickHeight) + 1;
    this.brickB = this.y + brickHeight - 2;
  }
  public void display() {
    if (hitNum == 0){ fill(0, 255, 0); } //green 
    else if (hitNum == 1) { fill(255, 255, 0); } // hit once = yellow 
    else if (hitNum == 2) { fill(255, 0, 0); } // hit twice = red
    
    //Does not draw broken bricks 
    if (this.hitNum != 3) {
      rect(this.x, this.y, brickWidth - 2, brickHeight - 2);
    }
  }
 
  public void brickCollision() {
    if (this.hitNum != 3) { 
      if ((xB-r/2 >= this.x && xB - r/2 <= this.brickR) && (yB + r/2 >= this.y && yB - r/2 <= this.brickB) && hit == false) {
        vy = -vy;
        hit=true;
        if (xB - r/2 <= this.brickR && xB - r/2 >= this.brickR - brickWidth/4) {
          vx = 1;
        }
        if (xB + r/2 >= this.x && xB + r/2 <= this.x + brickWidth/4) {
          vx = -1; 
        }
        //number of times brick has been hit
        this.hitNum++; 
      }
    }
  }
}
