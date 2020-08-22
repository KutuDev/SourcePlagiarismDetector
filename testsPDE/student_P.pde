
//maxX = 1496, maxY = 720

int screenHeight = 720; // set screen height
int screenWidth = 1496; //ser screen widt

boolean gameOn = false; // set variable to start ball movement
boolean checkleftPaddle = false;// set variable to check left paddle
boolean checkrightPaddle = false;//set variable to check right paddle

int leftpaddleX = 0; //Declares variable to hold X position of leftpaddle
int leftpaddleY = 0; //Declares variable to hold Y position of leftpaddle

int rightpaddleX = 1466; //Declares variable to hold X position of rghtpaddle
int rightpaddleY = 520; // Declares variable to hold X position of rightpaddle

int paddleWidth = 30; //set widht for both paddles
int paddleHeight = 200; //set height for both paddles

int ballX = screenWidth/2; //Declares variable to hold X position of ball
int ballY = screenHeight/2; //Declares variable to hold Y position of ball

int radius = 15; // set ball radius
int diameter = 30; // set diameter for ball

int fontSize= 40; // Declares variable for font

int P1scoreX = 688; //Set variable to hold X position of player1 score
int P1scoreY = 360; //Set variable to hold Y position of player1 score

int leftScore= 0; // Declares variable for first player score
int rightScore= 0; // Declares variable for second player score

int P2scoreX = 808; //Set variable to hold X position of player2 score
int P2scoreY = 360; // Set variable to hold Y position of player2 score

int xSpeed = 10; //Declares variable to move X position and speed of ball
int ySpeed = 6; //Declares variable to move Y position and speed of ball
int reverseSpeed = 1; //Declares variable for reverse speed

void setup() //run once
{
  fullScreen(); //Sets the program to run in full screen mode
}
void draw() //runs continuously until the program is stopped
{
  background(24, 124, 60);  //sets the background black

  stroke(255); //sets the color of the outline of shapes drawn below this code below green


  //Check if ball hits up or down walls
   if ((ballY-radius <= 0) || (ballY+radius) >= screenHeight) {
    ySpeed = ySpeed *-reverseSpeed;  //Reverse direction
  } 



  //Give increment to scores
  if (ballX-radius<0) {
    rightScore=rightScore +1;
    ballX = screenWidth/2;
    ballY = screenHeight/2;
    gameOn=false;
  } else if ( ballX+ radius >screenWidth) {
    leftScore=leftScore +1;
    ballX = screenWidth/2;
    ballY = screenHeight/2;
    gameOn=false;
  }



  Ball (ballX, ballY, diameter); //call function for ball

  moveBall(ballX, ballY, diameter); //call function to starr game and move ball
  if (mousePressed) {
    gameOn=true;
  }
  leftPaddle(leftpaddleX, leftpaddleY, paddleWidth);

  rightPaddle(rightpaddleX, rightpaddleY, paddleWidth);

  p1Score(leftScore, P1scoreX, P1scoreY);

  p2Score(rightScore, P2scoreX, P2scoreY);
  // check if ball hits left paddle
  checkleftPaddle = doesHit(leftpaddleX, leftpaddleY, paddleWidth, paddleHeight, ballX, ballY, radius);

   
  //Check if ball hits right paddle
  checkrightPaddle = doesHit(rightpaddleX, rightpaddleY, paddleWidth, paddleHeight, ballX, ballY, radius);
}

void Ball (int x, int y, int diameter) {
  fill(255); //sets the color of shapes drawn below this code gray
  ellipse(x, y, diameter, diameter); //draws an ellipse
} 
void leftPaddle(int x, int y, int paddleWidth) {
  fill(17, 149, 159);// sets the color of the shape drawn below this code blue

  rect(x, y, paddleWidth, paddleHeight); //draws a rectangle
  // move left paddle independently
  if (mouseX < screenWidth/2) {
    moveleftPaddle();
  }
}
void rightPaddle(int x, int y, int paddleWidth) {
  fill(17, 149, 159);// sets the color of the shape drawn below this code blue
  rect(x, y, paddleWidth, paddleHeight); //draws a rectangle
  //move right paddle independently
  if (mouseX >screenWidth/2) {
    moverightPaddle();
  }
}



//Move paddle vertically
void moveleftPaddle() {

  leftpaddleY = constrain(mouseY, 0, screenHeight - paddleHeight); //constrain paddle to drawing window
}


void moverightPaddle() {

  rightpaddleY = constrain(mouseY, 0, screenHeight - paddleHeight); //constrain paddle to drawing window
}

//Declare scores for both players
void p1Score(int leftScore, int x, int y) {

  fill(255); // sets the color of the text below this code white

  textSize(fontSize); //set text size to 40

  text(leftScore, x, y); //writes text on screen
}
void p2Score(int rightScore, int x, int y) {

  fill(255); // sets the color of the text below this code white

  textSize(fontSize); //set text size to 40

  text(rightScore, P2scoreX, P2scoreY); //writes text on screen
}

// define function to check paddle
boolean doesHit(int xPaddle, int yPaddle, int paddlewith, int paddleHeight, int xBall, int yBall, int radius) {



  int ballLeftEdge = xBall-radius; //left edge of ball
  int ballBottomEdge = yBall+radius; //bottom edge of ball
  int ballRightEdge = xBall+radius; //right edge of ball
  int ballTopEdge = yBall-radius; //top edge of ball

  int paddleLeftEdge = xPaddle; //left edge of paddle
  int paddleBottomEdge = yPaddle + paddleHeight; //bottom edge of paddle
  int paddleRightEdge = xPaddle + paddleWidth; //right edge of paddle
  int paddleTopEdge = yPaddle; //top edge of paddle

  if (ballBottomEdge >= paddleTopEdge //Check if bottom edge of ball and top edge of paddle overlap
    && ballTopEdge <= paddleBottomEdge //Check if top edge of ball and bottom edge of paddle overlap
    && ballLeftEdge <= paddleRightEdge //Check if left edge of ball and right edge of paddle overlap
    && ballRightEdge >= paddleLeftEdge ) //Check if right edge of ball and left edge of paddle overlap
  {   
    xSpeed = xSpeed *-reverseSpeed;//revese direction
    return true;
  } else { 
    return false;
  }
}
// define function to move ball
boolean moveBall(int x, int y, int diameter) {
  if (gameOn) {
    ballX = ballX -xSpeed;
    ballY = ballY -ySpeed;
    return true;
  } else {
    return false;
  }
}
