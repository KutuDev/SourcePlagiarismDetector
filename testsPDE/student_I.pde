//maxX=1536,maxY=720

float screenWidth=1536;  //the width of screen
float screenHeight=720;  //the height of screen

int ballX=768;  // declare the Variables to hold x position of ball
int ballY=360;  //declare the variables ato hold y position of ball
int ballWidth=50;  //the width of ball
int ballHeight=50;  //the height of ball
int xSpeed=5;  // ball's horizontal speed
int ySpeed=5;  //ball's vertical speed
int radius=25;

float paddleWidth=250;  // width of paddles
float paddleHeight=300;  //height of paddles

float leftPaddleX=0;  //declares the variables to hold x position of left paddle
float leftPaddleY=0;  //declares the variables to hold y position of left paddle

float rightPaddleX=1286;  // declares the variables to hold x position of right paddle
float rightPaddleY=420;  // declares the variables to hold y position of right paddle

int leftPlayerScoreX=365;  //declares the variables to hold x position of leftplayerscore
int rightPlayerScoreX=1000;  // declares the variables to hold x position of rightplayerscore
int scoreYP=500;  // declares the variables to hold y position of both playerscore
int leftPlayerScore=0;  //scores of left player
int rightPlayerScore=0;  //scores of right player
int sizeofText=100;  //sets the size of text

boolean gameOn=false;  //new variable to move ball
boolean hasOverlappedLeftPaddle = false;
boolean hasOverlappedRightPaddle = false;


void setup()  //run once
{
 fullScreen();  // run the program on full screen
 
}

void draw() { //run continuously

background(200); //sets the background to a dark red

displayBall();  //calls function to draw ball
gameOn=setGameMode();  // starts game if screen is pressed 
moveBall();  //moves ball if game is on
movePaddles();  //movePaddle(); //function moves paddles when screen is touched
checkWall();  //checks walls and determine which player scores a point
displayScores();  //calls function to write scores
displayPaddles();  //calls function to draw paddles
checkLeftPaddle();  //calls function to check left paddle and ball //overlap
checkRightPaddle();  //calls function to check right paddle and ball //overlap


}

void displayPaddles(){
  
fill(255,255,255); //sets the paddles' colour to green
stroke(0); //sets the paddles' outline to white
 rect(leftPaddleX, leftPaddleY, paddleWidth, paddleHeight);  //draw paddle1
fill(255,255,255); //sets the paddles' colour to blue
 rect(rightPaddleX, rightPaddleY, paddleWidth, paddleHeight);  //draw paddle2
}

void displayBall(){
  
  stroke(0);  //set the outline colour to white
  fill(255,0,0);  //set the inside white
  ellipse(ballX, ballY, ballWidth, ballHeight);  //draw ellipse
  }
  
  void displayScores(){
    
  fill(255,0,0);  // set color white
  textSize(sizeofText);  //set the text size 35
  text(leftPlayerScore, leftPlayerScoreX, scoreYP);  // set score for left player
  text(rightPlayerScore, rightPlayerScoreX, scoreYP);  //set score for right player
  }

  //check if mouse is pressed, set gameOn to true
  boolean setGameMode(){
    
  if (mousePressed) {
    gameOn=true;
    }
    return gameOn;
}

void moveBall(){
  
if (gameOn) {
    ballX=ballX+xSpeed; 
    ballY=ballY-ySpeed;
  }else{
    ballX =768; 
    ballY = 360;
    }
  }
  
void checkWall(){ 
  
 // check if ball hit top and bottom them make it bounce

  if ((ballY+radius <= 0) ||
    (ballY+radius)  >= screenHeight) {
    ySpeed=ySpeed * -1;  //reverse direction
  }
  
// check if ball hit right & left wall and increment score accordingly
if ((ballX+radius) >= screenWidth) {
    xSpeed=7;
    gameOn=false;
    
//move ball back to center 
    ballX =729; 
    ballY = 360;
    leftPlayerScore=leftPlayerScore+1;  //increment leftscore player by +1
    }
  else if ((ballX-radius <= 0)) {
    xSpeed=7;
    gameOn=false;
    

//move ball back to center 
    ballX =729; 
    ballY = 360;
    rightPlayerScore=rightPlayerScore+1;  //increment right score player by +1
  }
  }
  

//Check if there is an overlap   ball and Left paddle
 void checkLeftPaddle() {
   
hasOverlappedLeftPaddle = doesOverlap(leftPaddleX, leftPaddleY, paddleWidth, paddleHeight, ballX, ballY, radius);
  if (hasOverlappedLeftPaddle) {
xSpeed = xSpeed *-1; //reverse direction 
  }
  }
  
//Check if there is an overlap   ball and right paddle
  void checkRightPaddle() { 
  
  hasOverlappedRightPaddle = doesOverlap(rightPaddleX, leftPaddleY, paddleWidth, paddleHeight, ballX, ballY, radius); 
  if (hasOverlappedRightPaddle) {
    xSpeed = xSpeed *-1; //reverse direction 
  }
  }
  
void movePaddles(){ //move left or right paddle when corresponding side of screen is touched

if (mouseX < (screenWidth/2)){
  leftPaddleY = constrain(mouseY, leftPaddleX, screenHeight-paddleHeight);//move left paddle
  } else { 
    rightPaddleY = constrain( mouseY, leftPaddleX, screenHeight - paddleHeight); //move right paddle
    }
}
  //Checks if ball overlaps paddle
boolean doesOverlap(float paddleX, float paddleY, float paddleWidth, float paddleHeight, float ballX, float ballY, float radius) {
  float ballLeftEdge = ballX-radius; //left edge of ball
  float ballBottomEdge = ballY+radius; //bottom edge of ball
  float ballRightEdge = ballX+radius; //right edge of ball
  float ballTopEdge = ballY-radius; //top edge of ball

  float paddleLeftEdge = paddleX; //left edge of paddle
  float paddleBottomEdge = paddleY+paddleHeight; //bottom edge of paddle
  float paddleRightEdge = paddleX+paddleWidth; //right edge of paddle
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