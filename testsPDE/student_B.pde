//maxX = ***, maxY = ***

float screenWidth = 1920; //set to your maxX
float screenHeight = 1080; //set to your maxY


//paddleRightX (the x position of the right paddle) is 90 units from the 
//right edge of the screen. We do this because the paddle's width is 90 units. 
//So by subtracting 90 from maxX, the right paddle fits nicely at the 
//right edge of the screen.
float paddleRightX = 1830;  // maxX - paddleWidth = *** - 90 = ***

//y position of the left paddle is exactly half of the y axis
float paddleLeftY=0 ;  // maxY/2 = ***

//y position of the right paddle is exactly half of the y axis
float paddleRightY= 0;  // maxY/2 = ***

//x position of the left paddle is at 0
float paddleLeftX = 0;

float paddleWidth = 90;

float paddleHeight= 300;

float diameter = 80;  //diameter of the ball
float radius = 40; //since half the diameter is the radius

boolean hasOverlappedLeftPaddle = false;
boolean hasOverlappedRightPaddle = false;

int ballX = 960; 

int ballY = 540;  
int xSpeed = 5; //ball's horizontal speed
int ySpeed = 0; //ball's vertical speed

void setup()
{
  fullScreen(); //Sets the program to run in full screen mode
}
boolean gameOn= false;
void draw ()
{
  background (0); //set background to black each frame

  stroke (0, 0, 255); //use a blue outline for all shapes until stroke is run again with another color

  fill (0, 255, 0); //fill all shapes to green until fill is run with another color 
 movePaddle();
  //Draw paddles
  rect (paddleLeftX, paddleLeftY, paddleWidth, paddleHeight); //draw left paddle

  rect (paddleRightX, paddleRightY, paddleWidth, paddleHeight); //draw right paddle

  fill(255); //fill all shapes to white until fill is run with another color

  //set balls position to be position of a touch on the screen
  ballX = mouseX;
  ballY = mouseY;
  ballX = ballX+xSpeed;
  ballY = ballY+ySpeed;
  
    
 if (mousePressed){
  gameOn = true;
}
  //Move ball
  if (gameOn){
    
  ballX = ballX+xSpeed;
  ballY = ballY+ySpeed;
}
  //Check if ball hits left or right walls
  if ((ballX-radius < 0) || (ballX+radius) > screenWidth) {
    xSpeed = xSpeed * -1;  //Reverse direction
 }
  
 if ((ballY-radius <=0) || (ballY+radius) > screenWidth) {
    ySpeed = ySpeed * -1;
 }

    
  //Check if there is an overlap between ball and left paddle
  hasOverlappedLeftPaddle = doesOverlap(paddleLeftX, paddleLeftY, paddleWidth, paddleHeight, ballX, ballY, radius);

  if (hasOverlappedLeftPaddle) {

    fill (255, 0, 0); //fill all shapes to red until fill is run with another color
  }

  //Check if there is an overlap between ball and right paddle
  hasOverlappedRightPaddle = doesOverlap(paddleRightX, paddleRightY, paddleWidth, paddleHeight, ballX, ballY, radius); 

  if (hasOverlappedRightPaddle) {

    fill (0, 0, 255); //fill all shapes to blue until fill is run with another color
  }

  //Draw ball
  ellipse (ballX, ballY, diameter, diameter); //draw ball unto the screen
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
void movePaddle() {

 if(mouseX <= paddleLeftX + width/48 &&
 (mousePressed)){
    paddleLeftX= constrain(mouseY, 0, screenWidth - paddleHeight/4); //constrain paddle to drawing window

 }
 else if (mouseX >= paddleRightX && (mousePressed)){
   paddleRightX= constrain(mouseY,0,screenHeight/4);
 }

  paddleLeftX = constrain(mouseX, 0, screenHeight - paddleHeight); //constrain paddle to drawing window
  paddleLeftY= constrain(mouseY,0,screenWidth- paddleHeight);
}