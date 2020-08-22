int screenWidth = 800;//set your maxX
int screenHeight = 480;//set your maxY

int leftPaddleX = 0;//declare variable to hold x position of paddle
int leftPaddleY = 190;//declare variable to hold y position of paddle
int leftPaddleWidth = 25;//declare variable to hold width of ball
int leftPaddleHeight = 100;//declare variable to hold height of ball
int rightPaddleX = 775;//declare variable to hold x position of paddle
int rightPaddleY = 190;//declare variable to hold y position of paddle
int rightPaddleWidth = 25;//declare variable to hold width of ball
int rightPaddleHeight = 100;//declare variable to hold height of ball
int leftPlayerScoreX = 300;//declare variable to hold x position of score
int leftPlayerScoreY = 240;//declare variable to hold y position of score
int rightPlayerScoreX = 500;//declare variable to hold x position of score
int rightPlayerScoreY = 240;//declare variable to hold y position of score
int leftPlayerScore = 0;
int rightPlayerScore = 0;
int textSize = 30;//set the textSize to 30
int xSpeed = 5;;//ball's horizontal speed
int ySpeed = 5;;//ball's vertically speed
float diameter = 30;//declare variable to hold diameter of ball
float radius = 20;//since half width or height of the ball is the radius
boolean gameOn = false;//new variable to start the ball movement
boolean hasOverLappedLeftPaddle = false;
boolean hasOverLappedRightPaddle = false;

int ballX = 400;//declare variable to hold x position of ball
int ballY = 240;//declare variable to hold x position of ball
void setup(){ //run once
  
  fullScreen();//Sets the program to run in full screen mode
}
void draw(){ //run forever
  
  background(150);
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
 //Move paddle
void movePaddles(){
  if(mouseX < screenWidth/2){
  leftPaddleY = constrain(mouseY,0,screenHeight-leftPaddleHeight);
  }
  else{
     if(mouseX > screenWidth/2){
  rightPaddleY = constrain(mouseY,0,screenHeight-rightPaddleHeight);
  }
  }
}
//move the ball
void moveBall(){
  if(gameOn){
  ballX = ballX+xSpeed;
  ballY = ballY+ySpeed;
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
    ballX = screenWidth/2;
    ballY = screenHeight/2;
    
  }
 //check if the ball out of leftscreen and increase the score
  if((ballX+radius) >= screenWidth){
    leftPlayerScore = leftPlayerScore + 1;
    gameOn = false;
    ballX = screenWidth/2;
    ballY = screenHeight/2;
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
    stroke(0,255,255);//set the colour of outline shapes to light blue
  fill(0,0,255);//set the colour of shapes to blue
    rect(rightPaddleX,rightPaddleY,rightPaddleWidth,rightPaddleHeight);//draw a rightpaddle
  rect(leftPaddleX,leftPaddleY,leftPaddleWidth,leftPaddleHeight);//draw a leftpaddle 
  }
  //Draw ball
  void displayBall(){
    stroke(0,255,255);//set the colour of outline shapes to light blue
    fill(212);//set the colour of  shapes to below white
    ellipse(ballX,ballY,diameter,diameter);//draw a ball
  }
  //write score on screen
  void displayScore(){
    fill(225);//set the colour of text to white
  textSize(textSize);//set the textSize to 30
  text(leftPlayerScore,leftPlayerScoreX,leftPlayerScoreY);//write text on screen
  text(rightPlayerScore,rightPlayerScoreX,rightPlayerScoreY);//write text on screen
  
  }
  //check if the ball hit the leftPaddle
  void checkLeftPaddle() {
  hasOverLappedLeftPaddle = doesOverLap(leftPaddleX,leftPaddleY,leftPaddleWidth,leftPaddleHeight,ballX,ballY,radius);
  
  if (hasOverLappedLeftPaddle){ 
    xSpeed = xSpeed *-1;
  }
 }
 //check if the ball hit the rightPaddle
 void checkRightPaddle(){
   hasOverLappedRightPaddle = doesOverLap(rightPaddleX,rightPaddleY,rightPaddleWidth,leftPaddleHeight,ballX,ballY,radius);
  
  if (hasOverLappedRightPaddle){
    xSpeed = xSpeed *-1;
    
    }
 }
