//maxX = 1440, maxY = 720

//declare and initialize variables

float screenWidth = 1440; //set to your maxX
float screenHeight = 720; //set to your maxY

//declare and initialize variables for ball
float ballX = 720;
float ballY = 360;

float ballWidth = 80; //declare and initialize variable to hold width of ball
float ballHeight = 80; //declare and initialize varianle to hold height of ball
float xSpeed = 10; //declare and initialize variable to hold speed of x position of ball
float ySpeed = 10; //declare and initialize variable to hold speed of y position of ball
float radius = 40; //half of the width or height of the ball 

//declare and initialize variables for left and right paddle

float paddleLeftX = 0; //declare and initialize variable to hold x position of left paddle
float paddleLeftY = 0; //declare and initialize variable to hold y position of right paddle
float paddleWidth = 30; //declare and initialize variable to hold width of paddle
float paddleHeight = 200; //declare and initialize variable to hold height of paddle
float paddleRightX = 1390; //declare and initialize variable to hold x position of right paddle
float paddleRightY = 520; //declare and initialize variable to hold y position of right paddle

//declare and initialize variables for player score

float scoreLeft = 0; //declare and initialize variable to hold left player's score
float scoreLeftX = 340; //declare and initialize variable to hold x position of left player's score
float scoreLeftY = 390; //declare and initialize variable to hold y position of left player's score

float scoreRight = 0; //declare and initialize variable to hold right player's score
float scoreRightX = 840; //declare and initialize variable to hold x posution lf right player's score
float scoreRightY = 390; //declare and inktialize variable to hold y position of right player's score

float sizeText = 50; //declare and initialize variable to hold text size

int centerX = 720;
int centerY = 360;

boolean gameOn = false;

boolean hasOverlappedLeftPaddle = false;
boolean hasOverlappedRightPaddle = false;



void setup() //runs once
{
  fullScreen(); //Sets the program to run in full screen mode
  
}

void draw() //runs forever
{
  background(0); //Sets the background to black
  
  stroke(0, 0, 255); //Sets outline of shapes drawn below this code to blue
  
displayBall();  //call function to draw ball
gameOn=setGameMode();  // start game if screen is pressed 
moveBall();  //move ball if game is on
movePaddles();  //movePaddle(); //function to move paddles when screen is touched
checkWall();  //check walls and determine which player scores a point
displayPlayerScores();  //call function to write scores
displayPaddles();  //call function to draw paddles
checkLeftPaddle();  //call function to check left paddle and ball //overlap
checkRightPaddle();  //call function to check right paddle and ball //overlap

 }
  
  void displayPaddles(){
  fill(0, 255, 0); //Sets the color of shapes drawn below this code to green
  
  rect(paddleLeftX, paddleLeftY, paddleWidth, paddleHeight); //draws the first paddle exactly at the top left corner of the screen
  
  rect(paddleRightX, paddleRightY, paddleWidth, paddleHeight); //draws the second paddle exactly at the bottom right conner of the screen
  

}


   void displayBall(){
  
  fill(255, 0, 0); //Sets color of shapes drawn below this code to red
  
  ellipse(ballX, ballY, ballWidth, ballHeight); //draws the ball at the center of our screen
}  


  void displayPlayerScores(){
  //write scores
  
  fill(255); //Sets color of shapes drawn belowv this code to white
  
  textSize(sizeText); //Sets text size
  
  text(scoreLeft, scoreLeftX, scoreLeftY); //writes Left player's score at the left side of the screen
  
  text(scoreRight, scoreRightX, scoreRightY); //writes Right player's score at the right side of the screen
   
  }
  
  //check if mouse is pressed, set gameOn to true
  boolean setGameMode(){
   
    //Check if mouse is pressed, set gameOn to true
  if(mousePressed){
    gameOn =true;
  }
  return gameOn;
  } 

 void moveBall() {
  //make the ball move
  
  if (gameOn){
  ballX = ballX + xSpeed;
  ballY = ballY - ySpeed;
  }
  else{ 
    ballX = centerX;
    ballY = centerY;
  }
 } 



  
void checkWall(){ 
  
  //Check if ball hits top or bottom walls
  if((ballY - radius <= paddleLeftY) || (ballY + radius) >= screenHeight){
    
    ySpeed = ySpeed * -1; //Reverse direction
  } 
  
  //Check if ball hits left or right walls
  if ((ballX-radius <= paddleLeftX) || (ballX+radius) >= screenWidth) {

    xSpeed = xSpeed * -1;  //Reverse direction
  }
  
    if((ballX + radius) >= screenWidth){scoreLeft+= 1;
    gameOn = false; //Increase leftPlayerScore

   //move ball back to center 
    ballX =centerX; 
    ballY =centerY;
  }

  else if((ballX - radius <=paddleLeftX)){scoreRight+= 1;
    gameOn = false; //Increase rightPlayerSore
 
 //move ball back to center 
    ballX = centerX; 
    ballY = centerY;
  }
} 
 
   
  
 //Check if there is an overlap   ball and Left paddle
 void checkLeftPaddle() {
   
   
hasOverlappedLeftPaddle = doesOverlap(paddleLeftX, paddleLeftY, paddleWidth, paddleHeight, ballX, ballY, radius);
  if (hasOverlappedLeftPaddle) {
xSpeed = xSpeed * -1; //reverse direction 
  }
  }
  
  //Check if there is an overlap   ball and right paddle
  void checkRightPaddle() { 
  
  hasOverlappedRightPaddle = doesOverlap(paddleRightX, paddleRightY, paddleWidth, paddleHeight, ballX, ballY, radius); 
  if (hasOverlappedRightPaddle) {
    xSpeed = xSpeed * -1; //reverse direction 
  }
  }
  
void movePaddles(){ //move left or right paddle when corresponding side of screen is touched

if (mouseX < (screenWidth/2)){
  paddleLeftY = constrain(mouseY, paddleLeftX, screenWidth - paddleHeight);//move left paddle
  } else { 
    paddleRightY = constrain( mouseY, paddleLeftY, screenWidth - paddleHeight); //move right paddle
    }
}
  //Checks if ball overlaps paddle
boolean doesOverlap(float paddleX, float paddleY, float paddleW, float paddleH, float ballX, float ballY, float radius) {
  float ballLeftEdge = ballX-radius; //left edge of ball
  float ballBottomEdge = ballY+radius; //bottom edge of ball
  float ballRightEdge = ballX+radius; //right edge of ball
  float ballTopEdge = ballY-radius; //top edge of ball

  float paddleLeftEdge = paddleX; //left edge of paddle
  float paddleBottomEdge = paddleY+paddleH; //bottom edge of paddle
  float paddleRightEdge = paddleX+paddleW; //right edge of paddle
  float paddleTopEdge = paddleY; //top edge of paddle

  if (ballBottomEdge >= paddleTopEdge //Check if bottom edge of ball and top edge of paddle overlap
    && ballTopEdge <= paddleBottomEdge //Check if top edge of ball and bottom edge of paddle overlap
    && ballLeftEdge <= paddleRightEdge //Check if left edge of ball and right edge of paddle overlap
    && ballRightEdge >= paddleLeftEdge ) //Check if right edge of ball and left edge of paddle overlap
  {   
    return true;
  } else { 
    return false;
  }
}