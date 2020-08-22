//maxX = 1536 , maxY = 720

int screenWidth = 1536; //set to your maxX
int screenHeight = 720; //set to your maxY

int halfScreenWidth = 768; // maxX/2 = 768

int halfScreenHeight = 360; // maxY/2 = 360

int rightPaddleX = 1436; // holds X position of the right paddle

int leftPaddleY= 0;  // holds Y position of left paddle 

int rightPaddleY= 420;  // holds Y position of the right paddle

int leftPaddleX = 0; // hold X position of the left paddle

int leftPaddleWidth = 100;

int rightPaddleWidth = 100;

int leftPaddleHeight= 300;

int rightPaddleHeight = 300;

int ballX = 768; //declare the variable to hold X position of ball
int ballY = 360; //declare the variable to hold Y position of ball
int diameter = 80; //declare variable to draw width of ball
int xSpeed = 3; //ball's horizontal speed
int ySpeed = 3; //ball's vertical speed
int radius = 40; //since half the width or the height of the ball is the radius

int leftPlayerScoreX = 384; //declare variable to hold X position of score on the left
int leftPlayerScoreY = 360; //declare variable to hold Y position of score on the left

int rightPlayerScoreX = 1152; //declare variable to hold X postion of score on the right
int rightPlayerScoreY = 360; //declare varibale to hold Y position of score on the right 

int textSize = 60;

int leftPlayerScore = 0;
int rightPlayerScore = 0;

boolean gameOn = false; //variable to start ball's movement

boolean hasOverlappedLeftPaddle = false;
boolean hasOverlappedRightPaddle = false;


void setup() {
  fullScreen(); //Sets the program to run in full screen mode
  
}

void draw() {
  background(128); //set background colour to ash
 
 displayPaddles();//draw a paddle
 displayBall();//draw a ball
 displayScore();//write text on screen
 movePaddles();//move paddles vertically
 moveBall();//move ball
 checkWall();//check if the ball hit the walls
 checkLeftPaddle();//check if the ball hit the leftPaddle
 checkRightPaddle();//check if the ball hit the rightPaddle
 setGameMode();//set to gamemode
}

 //Move paddle
void movePaddles(){
  if(mouseX < halfScreenWidth){
  leftPaddleY = constrain(mouseY,0,screenHeight-leftPaddleHeight);
  }
  else{
     if(mouseX > halfScreenWidth){
  rightPaddleY = constrain(mouseY,0,screenHeight-rightPaddleHeight);
  }
  }
}
//move the ball
void moveBall(){
  if(gameOn){
  ballX = ballX-xSpeed;
  ballY = ballY-ySpeed;
    }
}

void checkWall(){
  //check if the ball hit the left or right wall
  if((ballX-radius <=  0)  ||  (ballX+radius) >= screenWidth){
    xSpeed = xSpeed * -1;
    }
  
  //check if the ball hit the top or bottom wall
  if ((ballY-radius <=  0)  ||  (ballY+radius) >= screenHeight){ 
    ySpeed = ySpeed * -1;

 }
 //check if the ball out of screen and increase the score
 if (ballX-radius <= 0){
    rightPlayerScore = rightPlayerScore + 1;
    gameOn = false;
    ballX = halfScreenWidth;
    ballY = halfScreenHeight;
    
  }
 //check if the ball out of leftscreen and increase the score
  if((ballX+radius) >= screenWidth){
    leftPlayerScore = leftPlayerScore + 1;
    gameOn = false;
    ballX = halfScreenWidth;
    ballY = halfScreenHeight;
  }
  
}
//set to gamemode
void setGameMode(){
  if (mousePressed){
   gameOn = true;

 }
 }
 //Draw paddle
  void displayPaddles(){
  stroke(255,0,0);//set the colour of outline shapes to red
  fill(0,255,0);//set the colour of shapes to green
    rect(rightPaddleX,rightPaddleY,rightPaddleWidth,rightPaddleHeight);//draw a rightpaddle
    rect(leftPaddleX,leftPaddleY,leftPaddleWidth,leftPaddleHeight);//draw a leftpaddle 
  }
  //Draw ball
  void displayBall(){
  stroke(255,0,0);//set the colour of outline shapes to red
  fill(0,0,255);//set the colour of  shapes to below blue
    ellipse(ballX,ballY,diameter,diameter);//draw a ball
  }
  //write score on screen
  void displayScore(){
  fill(225);//set the colour of text to white
    textSize(textSize);//set the textSize to 60
    text(leftPlayerScore,leftPlayerScoreX,leftPlayerScoreY);//write text on screen
    text(rightPlayerScore,rightPlayerScoreX,rightPlayerScoreY);//write text on screen
  
  }
  
  //check if the ball hit the leftPaddle
  void checkLeftPaddle() {
  hasOverlappedLeftPaddle = doesOverLap(leftPaddleX,leftPaddleY,leftPaddleWidth,leftPaddleHeight,ballX,ballY,radius);
  
  if (hasOverlappedLeftPaddle){ 
    xSpeed = xSpeed *-1;
  }
 }
 //check if the ball hit the rightPaddle
 void checkRightPaddle(){
   hasOverlappedRightPaddle = doesOverLap(rightPaddleX,rightPaddleY,rightPaddleWidth,leftPaddleHeight,ballX,ballY,radius);
  
  if (hasOverlappedRightPaddle){
    xSpeed = xSpeed *-1;
    
    }
 }

//Checks if ball overlaps paddle
  boolean doesOverLap(float xPaddle, float yPaddle, float widthPaddle, float heightPaddle, float xBall, float yBall, float radius) {
  float ballLeftEdge = xBall-radius; //left edge of ball
  float ballBottomEdge = yBall+radius; //bottom edge of ball
  float ballRightEdge = xBall+radius; //right edge of ball
  float ballTopEdge = yBall-radius; //top edge of ball

  float paddleLeftEdge = xPaddle; //left edge of paddle
  float paddleBottomEdge = yPaddle+heightPaddle; //bottom edge of paddle
  float paddleRightEdge = xPaddle+widthPaddle; //right edge of paddle
  float paddleTopEdge = yPaddle; //top edge of paddle

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