
//maxX=1532,maxY=720

float screenWidth=1532;  //the width of screen
float screenHeight=720;  //the height of screen

  int ballX = 730; //Declares variable to hold X position of ball. 
  int ballY = 360; //Declares variable to hold Y position of ball. 
  int ballWidth = 40; //Width of ball
  int ballHeight = 40; //Height of ball
  int xSpeed = 15; //ball's horizontal speed
  int ySpeed = 15; //ball's vertical speed
  int radius = 40; //since half the width or the height of the ball is the radius

  float leftPaddleX = 0; //Declares variable to hold X position of left rectangle. 
  float leftPaddleY = 0; //Declares variable to hold Y position of left rectangle. 
  
  
  float rightPaddleX = 1380; //Declares variable to hold X position of right rectangle. 
  float rightPaddleY = 420; //Declares variable to hold Y position of right rectangle. 
  
  float paddleWidth = 50; //Width of peddle
  float paddleHeight = 150; //Height of peddle
  
  int leftPlayerScore = 0; //Left player score
  int leftPlayerScoreX = 400; //Declares variable to hold X position of left player score 
  int leftPlayerScoreY = 380; //Declares variable to hold Y position of left player score
  
  int rightPlayerScore = 0; //Right player score 
  int rightPlayerScoreX = 1000; //Declares variable to hold X position of right player score 
  int rightPlayerScoreY = 380; //Declares variable to hold Y position of right player score 
  
  int playerScoreSize = 50; //Declares variable to set text size to 50
  
  int reverseDirection = -1; //Reverse direction of ball
  int incScore= 1; //Increase player score by one
  int centerX = 730; //Declare ball to hold X value of the center 
  int centerY = 360; //Declares ball to hold Y value of the center
  
  

 boolean gameOn = false; //new variable to start ball movement
 boolean hasOverlappedLeftPaddle = false;
 boolean hasOverlappedRightPaddle = false;


void setup()  //run once
{
 fullScreen();  // run the program on full screen
 
}

void draw() { //run continuously

background(0); //sets the background black
stroke(255); // sets outline of all drawings white 
  
displayBall();  //call function to draw ball
gameOn=setGameMode();  // start game if screen is pressed 
moveBall();  //move ball if game is on
movePaddles();  //movePaddle(); //function to move paddles when screen is touched
checkWall();  //check walls and determine which player scores a point
displayScores();  //call function to write scores
displayPaddles();  //call function to draw paddles
checkLeftPaddle();  //call function to check left paddle and ball //overlap
checkRightPaddle();  //call function to check right paddle and ball //overlap


}

void displayPaddles(){
  
  fill(255,0,0); //set rectangle red
  rect(leftPaddleX, leftPaddleY, paddleWidth, paddleHeight); // draws a rectangle 
 
  fill(255,0,0); //sets rectangle red
  rect(rightPaddleX,rightPaddleY,paddleWidth ,paddleHeight); //draws a rectangle 
} 
  

void displayBall(){
  
  fill(47,127,0); //sets ellipse green 
  ellipse(ballX,ballY,ballWidth, ballHeight); // draws an ellipse
 
  }
  
  void displayScores(){
    
  fill(246,191,32) ; //set text yellow 
  textSize(playerScoreSize) ; //set text to 50
  
  text(leftPlayerScore, leftPlayerScoreX, leftPlayerScoreY) ; //writes text on screen 
  text(rightPlayerScore, rightPlayerScoreX, rightPlayerScoreY); //writes text on screen 
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
  if((ballY - radius <= leftPaddleY) || (ballY + radius) >= screenHeight){
    
    ySpeed = ySpeed * reverseDirection; //Reverse direction
  } 
  
  //Check if ball hits left or right walls
  if ((ballX-radius <= leftPaddleX) || (ballX+radius) >= screenWidth) {

    xSpeed = xSpeed * reverseDirection;  //Reverse direction
  }
  
    if((ballX + radius) >= screenWidth){leftPlayerScore+= incScore;
    gameOn = false; //Increase leftPlayerScore

   //move ball back to center 
    ballX =centerX; 
    ballY =centerY;
  }

  else if((ballX - radius <=leftPaddleX)){rightPlayerScore+= incScore;
    gameOn = false; //Increase rightPlayerSore
 
 //move ball back to center 
    ballX = centerX; 
    ballY = centerY;
  }
} 
 
   
  
 //Check if there is an overlap   ball and Left paddle
 void checkLeftPaddle() {
   
   
hasOverlappedLeftPaddle = doesOverlap(leftPaddleX, leftPaddleY, paddleWidth, paddleHeight, ballX, ballY, radius);
  if (hasOverlappedLeftPaddle) {
xSpeed = xSpeed *reverseDirection; //reverse direction 
  }
  }
  
  //Check if there is an overlap   ball and right paddle
  void checkRightPaddle() { 
  
  hasOverlappedRightPaddle = doesOverlap(rightPaddleX, rightPaddleY, paddleWidth, paddleHeight, ballX, ballY, radius); 
  if (hasOverlappedRightPaddle) {
    xSpeed = xSpeed * reverseDirection; //reverse direction 
  }
  }
  
void movePaddles(){ //move left or right paddle when corresponding side of screen is touched

if (mouseX < (screenWidth/2)){
  leftPaddleY = constrain(mouseY, leftPaddleX, screenHeight-paddleHeight);//move left paddle
  } else { 
    rightPaddleY = constrain( mouseY, leftPaddleY, screenHeight - paddleHeight); //move right paddle
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