float vx = 3; 
float vy = 2;
float x=120, y=220 ;
float batY = 300, h = 40, w = 60; 
float r = 15; 


void setup() {
 size(500, 500) ;
 noStroke();
}


void draw() {
 background(0);
 fill(255);
 ellipse(x, y, 2*r, 2*r);
 rect(mouseX-w, batY, w*2, h); 
 x += vx; 
 y += vy;

// Ball bounces off walls
 if (x+r > width || x-r<0){ vx = -vx; }
 if (y+r > height|| y-r<0){ vy = -vy; } 

 this.batCollision();
}


void batCollision(){
   if (y+r > batY && y-r<batY+h && x>mouseX-w && x<mouseX + w*2){
   vy = -vy; 
 }
 if (x-r<mouseX+w && x+r>mouseX-w && y>batY && y<batY+h){
   vx = -vx; 
 }
}
