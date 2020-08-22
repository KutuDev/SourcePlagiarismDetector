//maxX = 1440, maxY = 720

float screenWidth = 1440; //set to your maxX
float screenHeight = 720; //set to your maxY
float halfScreenWidth = 720; 

int ballX = 720; //Declare variable to hold x position of ball
int ballY = 360; //Declare variable to hold y position of ball
int ballWidth = 40; //variable for ball width
int ballHeight = 40; //variable for ball height

float rectX = 0; //Declare variable to hold x position of top left paddle
float rectY = 0; //Declare variable to hold y position of top left paddle
float rectWidthX = 40; //variable for ball width
float rectHeightY = 150; //variable for ball height

float rectA = 1400; //Declare variable to hold x position of bottom right paddle
float rectB = 570; //Declare variable to hold y position of top bottom right paddle
float rectWidthA = 40; //variable for ball width
float rectHeightB = 150; //variable for ball height

int scoreA = 0; //left player score
int textX = 550; //x position of left player score
int textY = 360; //y position of left player score
int textSizeA = 40; //text size of the score

int scoreB = 0; //right player score
int textK = 880; //x position of right player score
int textL = 360; //y position of right player score
int textSizeB = 40; //text size of player score

int xSpeed = 2; // ball's horizontal speed
int ySpeed = 5; //ball's vertical speed
int radius = 20; //half of the width and height of the ball

int ballXReset = 720; //reset position for ballX
int ballYReset = 360; //reset position for ballY

boolean gameOn = false; //start ball's Movement

boolean hasOverlappedLeftPaddle = false;
boolean hasOverlappedRightPaddle = false;

void setup() //runs once
{
  fullScreen(); //Sets the program to run in full screen mode
  
}

void draw() //runs forever
{ 
  background(0); //black background
  
  
  checkRightPaddle();
  checkLeftPaddle();
  movePaddle(); //
  fill(0,255,0); //fill top left paddle with light green
  stroke(0,0,255); //outline top left paddle with blue
  rect(rectX,rectY,rectWidthX,rectHeightY); //top left paddle
  
  fill(0,255,0); //fill bottom right paddle with light green
  stroke(0,0,255); //outline bottom right paddle with blue
  rect(rectA,rectB,rectWidthA,rectHeightB); //bottom right paddle
   
  
  fill(255); //fill ellipse with white
  stroke (0,0,255); //outline ellipse with blue
  ellipse(ballX, ballY, ballWidth, ballHeight); //ellipse
  
  textSize(textSizeA); //sets text size to 40
  text(scoreA,textX,textY); //writes text program

  textSize(textSizeB); //sets text size to 40
  text(scoreB,textK,textL); //writes text program


//Checks if ball overlaps paddle

 }boolean doesOverlap(float xPaddle, float yPaddle, float widthPaddle, float heightPaddle, float xBall, float yBall, float radius) {

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
   
  //Function to enable Movement of paddles
  }void movePaddle(){
  if(mouseX < halfScreenWidth){
    rectY = constrain
    (mouseY, 0,screenHeight - rectHeightY);
  } else { 
    rectB = constrain
    (mouseY, 0,screenHeight - rectHeightB); 
  }
  
   // Check if there is an overlap between ball and right paddle then bounce ball
  }void checkRightPaddle()
  { hasOverlappedRightPaddle = doesOverlap(rectA, rectB, rectWidthA, rectHeightB, ballX, ballY, radius);
   if (hasOverlappedRightPaddle) {
    xSpeed = xSpeed *-1; //reverse direction
  }
  
  //Check if there is an overlap between ball and left paddle then bounce ball
  }void checkLeftPaddle()
  { hasOverlappedLeftPaddle = doesOverlap(rectX, rectY, rectWidthX, rectHeightY, ballX, ballY, radius);
   if (hasOverlappedLeftPaddle) {
    xSpeed = xSpeed *-1;// reverse direction
  }
 
  //Check if mouse is pressed, set gameOn to true
  if (mousePressed){
    gameOn = true;
  }
  
  //Move ball
  if (gameOn){
    ballX = ballX+xSpeed;
    ballY = ballY+ySpeed;
  }
  
  //check if ball hits left or right walls
  if ((ballY-radius <= 0) || (ballY+radius) >= screenHeight){
    ySpeed = ySpeed * -1; //Reverse direction
  }
  if (ballX-radius <= 0){
    scoreB = scoreB + 1; //Increase scoreB
    ballX = ballXReset; //reset position for ballX
    ballY = ballYReset; //reset position for ballY
    gameOn = false;
    xSpeed = xSpeed * -1; //Reverse direction
    ySpeed = ySpeed * -1; //Reverse direction
    
  }else if(ballX >=screenWidth){
    scoreA = scoreA + 1; //Increase scoreA
    ballX = ballXReset; //reset position for ballX
    ballY = ballYReset; //reset position for ballY
    gameOn = false;
    xSpeed = xSpeed * -1; //Reverse direction
    ySpeed = ySpeed * -1; //Reverse direction
  
  }
}

