//maxX = 2312, maxY = 1080

int screenWidth = 2312; // set to your maxX 
int screenHeight = 1080; // set to your maxY

int halfScreenWidth = 1156; //sets screen to half of maxX
int halfScreenHeight = 540; //sets screen to half of maxY 

int numberZero = 0; // Variable for all 0 magic numbers 
int numberOne = 1; // Variable for all 1 magic numbers
int negativeOne = -1; // Variable for all -1 magic numbers
int numberTwo = 2; // Variable for all 2 magic numbers

//paddleRightX (the x position of the right paddle) is 90 units from the 
//right edge of the screen. We do this because the paddle's width is 90 units. 
//So by subtracting 90 from maxX, the right paddle fits nicely at the 
//right edge of the screen.
float paddleRightX = 2222;  // maxX - paddleWidth = 2312 - 90 = 2222

//y position of the left paddle is exactly half of the y axis
float paddleLeftY= 0;  

//y position of the right paddle is exactly half of the y axis
float paddleRightY= 780;  // maxY/2 = 540

//x position of the left paddle is at 0
float paddleLeftX = 0;

float paddleWidth = 90;

float paddleHeight= 300;

//x position of the ball is exactly half of the x axis
float ballX = 1156;  // maxX/2 = 2312/2 = 1156

//y position of the ball is exactly half of the y axis
float ballY = 540;  // maxY/2 = 1080/2 = 540
float ballWidth = 60; //declare and initialize variable to hold width of ball
float ballHeight = 60; //declare and initialize varianle to hold height of ball
float xSpeed = 20; //declare and initialize variable to hold speed of x position of ball
float ySpeed = 20; //declare and initialize variable to hold speed of y position of ball
float radius = 30; //half of the width or height of the ball 


//declare and initialize variables for player score

float scoreLeft = 0; //declare and initialize variable to hold left player's score
float scoreLeftX = 680; //declare and initialize variable to hold x position of left player's score
float scoreLeftY = 540; //declare and initialize variable to hold y position of left player's score

float scoreRight = 0; //declare and initialize variable to hold right player's score
float scoreRightX = 1568; //declare and initialize variable to hold x posution lf right player's score
float scoreRightY = 540; //declare and inktialize variable to hold y position of right player's score

float sizeText = 50; //declare and initialize variable to hold text size

int centerX = 1156;
int centerY = 540;

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

  stroke(255, 0, 0); //Sets outline of shapes drawn below this code to blue

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

void displayPaddles() {
  fill (205, 248, 37); //fill all shapes to a shade of yellow until fill is run with another color 

  rect(paddleLeftX, paddleLeftY, paddleWidth, paddleHeight); //draws the first paddle exactly at the top left corner of the screen

  rect(paddleRightX, paddleRightY, paddleWidth, paddleHeight); //draws the second paddle exactly at the bottom right conner of the screen
}


void displayBall() {

  fill(0, 0, 255);

  ellipse(ballX, ballY, ballWidth, ballHeight); //draws the ball at the center of our screen
}  


void displayPlayerScores() {
  //write scores

  fill(255); //Sets color of shapes drawn belowv this code to white

  textSize(sizeText); //Sets text size

  text(scoreLeft, scoreLeftX, scoreLeftY); //writes Left player's score at the left side of the screen

  text(scoreRight, scoreRightX, scoreRightY); //writes Right player's score at the right side of the screen
}

//check if mouse is pressed, set gameOn to true
boolean setGameMode() {

  //Check if mouse is pressed, set gameOn to true
  if (mousePressed) {
    gameOn =true;
  }
  return gameOn;
} 

void moveBall() {
  //make the ball move

  if (gameOn) {
    ballX = ballX + xSpeed;
    ballY = ballY - ySpeed;
  } else { 
    ballX = centerX;
    ballY = centerY;
  }
} 




void checkWall() { 

  //Check if ball hits top or bottom walls
  if ((ballY - radius <= numberZero) || (ballY + radius) >= screenHeight) {

    ySpeed = ySpeed * negativeOne; //Reverse direction
  } 

  //Check if ball hits left or right walls
  if ((ballX-radius <= numberZero) || (ballX+radius) >= screenWidth) {

    xSpeed = xSpeed * negativeOne;  //Reverse direction
  }

  if ((ballX + radius) >= screenWidth) {
    scoreLeft+= numberOne;
    gameOn = false; //Increase leftPlayerScore

    //move ball back to center 
    ballX =centerX; 
    ballY =centerY;
  } else if ((ballX - radius <=paddleLeftX)) {
    scoreRight+= numberOne;
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
    xSpeed = xSpeed * negativeOne; //reverse direction
  }
}

//Check if there is an overlap   ball and right paddle
void checkRightPaddle() { 

  hasOverlappedRightPaddle = doesOverlap(paddleRightX, paddleRightY, paddleWidth, paddleHeight, ballX, ballY, radius); 
  if (hasOverlappedRightPaddle) {
    xSpeed = xSpeed * negativeOne; //reverse direction
  }
}

void movePaddles() { //move left or right paddle when corresponding side of screen is touched

  if (mouseX < (screenWidth/numberTwo)) {
    paddleLeftY = constrain(mouseY, paddleLeftX, screenHeight-paddleHeight);//move left paddle
  } else { 
    paddleRightY = constrain( mouseY, paddleLeftY, screenHeight - paddleHeight); //move right paddle
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
