//maxX = 1280, maxY = 720

float screenWidth = 1280; //set to your maxX
float screenHeight = 720; //set to your maxY
int screenW = 1280;
int screenH = 720;
int xSpeed = 2;
int ySpeed = 15;
int textX1 = 400; // Declare variable to hold left score's X position

int textY1 = 360; // Declare variable to hold left score's Y position

int textX2 = 880; // Declare variable to hold right score's X position

int textY2 = 360; // Declare variable to hold right score's Y position

int textSize = 30; // declare variable for text size

int scoreRight = 0; // declare variable for initial right score

int scoreLeft = 0; // declare variable for initial left score


//paddleRightX (the x position of the right paddle) is 90 units from the 
//right edge of the screen. We do this because the paddle's width is 90 units. 
//So by subtracting 90 from maxX, the right paddle fits nicely at the 
//right edge of the screen.
float paddleRightX = 1250;  // maxX - paddleWidth = 1280 - 90 = 1190

//y position of the left paddle is exactly half of the y axis
float paddleLeftY= 360;  // maxY/2 = 360

//y position of the right paddle is exactly half of the y axis
float paddleRightY= 360;  // maxY/2 = 360

//x position of the left paddle is at 0
float paddleLeftX = 0;

float paddleWidth = 30;

float paddleHeight= 150;

float diameter = 80;  //diameter of the ball
float radius = 40; //since half the diameter is the radius

boolean hasOverlappedLeftPaddle = false;
boolean hasOverlappedRightPaddle = false;
boolean gameOn = false;
boolean movePaddle = false;

int ballX = 640; 

int ballY = 360;  

void setup()
{
  fullScreen(); //Sets the program to run in full screen mode
}

void draw ()
{
  background (0, 255, 0); //set background to green each frame

  stroke (0, 0, 255); //use a blue outline for all shapes until stroke is run again with another color
  
  fill (255, 0, 0);
   

  //Draw paddles
  rect (paddleLeftX, paddleLeftY, paddleWidth, paddleHeight); //draw left paddle

  rect (paddleRightX, paddleRightY, paddleWidth, paddleHeight); //draw right paddle

  fill(255, 255, 255); //fill all shapes to white until fill is run with another color

  //draw ball
  ellipse (ballX, ballY, diameter, diameter);
  
  //draw text
  textSize(textSize); //set text size to 30
  
  text(scoreRight, textX1,textY1); //write text rep left player score
  
  text(scoreLeft, textX2, textY2);  //write text rep right player score
  
  //Move paddle horizontally
  if (movePaddle) {

  paddleLeftY = constrain(mouseY, 0, screenH - paddleWidth); //constrain paddle to drawing window
}
  
  //Check if there is an overlap between ball and left paddle
  hasOverlappedLeftPaddle = doesOverlap(paddleLeftX, paddleLeftY, paddleWidth, paddleHeight, ballX, ballY, radius);

  if (hasOverlappedLeftPaddle) {

    fill (255, 0, 0); //fill all shapes to red until fill is run with another color
  }
  //Check if mouse is pressed, set gameOn to true
  if (mousePressed){
    gameOn = true;
  }

  //Move ball
  if (gameOn){
    ballX = ballX-xSpeed;
    ballY = ballY-ySpeed;
  }else{
    ballX = screenW/2;
    ballY = screenH/2;
  }
  
  //Check if ball hits top or bottom walls
  if ((ballY-radius < 0) || (ballY+radius) >= screenHeight) {

    ySpeed = ySpeed * -1;  //Reverse direction
  }
  
  //check if ball crosses right or left walls
  if ((ballX-radius <= 0)){
    scoreLeft+= 1;
    gameOn = false;
  }
  if ((ballX+radius) >= screenWidth){
    scoreRight+= 1;
    gameOn = false;
  }
  
  //Check if there is an overlap between ball and right paddle
  hasOverlappedRightPaddle = doesOverlap(paddleRightX, paddleRightY, paddleWidth, paddleHeight, ballX, ballY, radius); 

  if (hasOverlappedRightPaddle) {

     ySpeed = ySpeed * -1;  //fill all shapes to blue until fill is run with another color
  }

}

//Checks if ball overlaps paddle

boolean doesOverlap(float xPaddle, float yPaddle, float widthPaddle, float heightPaddle, float xBall, float yBall, float radius) {

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
