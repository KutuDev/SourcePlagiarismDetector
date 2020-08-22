//maxX=2190 ,maxY=1080 

float screenWidth=2190;  //the width of screen
float screenHeight=1080;  //the height of screen

// code for pong ball
int ballX=1095;  // declare the variables to hold x position of ball
int ballY= 540;//declare the variables ato hold y position of ball
int ballWidth=50;  //the width of ball
int ballHeight=50;  //the height of ball
int xSpeed=10;  // ball's horizontal speed
int ySpeed=10;  //ball's vertical speed
int radius=25; // ball's radius


// Code for paddles
float leftPaddleX=0;  //declares the variables to hold x position of left paddle
float leftPaddleY=0;  //declares the variables to hold y position of left paddle

float rightPaddleX=2160;  // declares the variables to hold x position of right paddle
float rightPaddleY=880; // declares the variables to hold y position of right paddle

float widthOfPaddles=30;  // width of paddles
float heightOfPaddles=170;  //height of paddles



int player1X=548;  //declares the variables to hold x position of left player's score
int player2X=1643;  // declares the variables to hold x position of right player's score
int player1Y2Y=540; // declares the variables to hold y position of both player's scores
int leftScore=0;  //scores of left player
int rightScore=0;  //scores of right player
int sizeNum=70;  //sets the size of text

boolean gameOn=false;  //new variable to move ball
boolean hasOverlappedLeftPaddle = false;
boolean hasOverlappedRightPaddle = false;


void setup()  //run once
{
fullScreen();  // run the program on full screen

}

void draw() { //run continuously

background(70); //sets the background to a dark red

// calling functions

gameOn=setGameMode();  // starts game if screen is pressed 
displayPaddles();  //calls function to draw paddles
checkLeftPaddle();  //calls function to check left paddle and ball //overlap
checkRightPaddle();  //calls function to check right paddle and ball //overlap
movePaddles();  //movePaddle(); //function moves paddles when screen is touched
displayBall();  //calls function to draw ball
moveBall();  //moves ball if game is on
checkWall();  //checks walls and determine which player scores a point
displayScores();  //calls function to write scores




}

// Defining functions

void displayPaddles(){
  
stroke(246,236,32); //sets the outline of the paddles  yellow
fill(145,171,70); //sets the colour inside the paddles grren
rect(leftPaddleX,leftPaddleY,widthOfPaddles,heightOfPaddles);  //draw paddle1
rect(rightPaddleX,rightPaddleY,widthOfPaddles,heightOfPaddles);  //draw paddle2
}

//Check if there is an overlap   ball and Left paddle
void checkLeftPaddle() {
   
hasOverlappedLeftPaddle = doesOverlap(leftPaddleX,leftPaddleY,widthOfPaddles,heightOfPaddles, ballX, ballY, radius);
  if (hasOverlappedLeftPaddle) {
xSpeed = xSpeed *-1; //reverse direction 
  }
  }


 //Check if there is an overlap between  ball and right paddle
  void checkRightPaddle() { 
  
  hasOverlappedRightPaddle = doesOverlap(rightPaddleX,rightPaddleY,widthOfPaddles,heightOfPaddles, ballX, ballY, radius); 
  if (hasOverlappedRightPaddle) {
    xSpeed = xSpeed *-1; //reverse direction 
  }
  }



void movePaddles(){ //move left or right paddle when corresponding side of screen is touched

if (mouseX < (screenWidth/2)){
  leftPaddleY = constrain(mouseY,leftPaddleX, screenHeight-heightOfPaddles);//move left paddle
  } else { 
    rightPaddleY = constrain( mouseY,leftPaddleX, screenHeight - heightOfPaddles); //move right paddle
    }
}



void displayBall(){
  
  fill(89,10,49);  //set the colour inside the ball dull red
  ellipse(ballX, ballY, ballWidth, ballHeight);  //draw ellipse
  }
  



void moveBall(){
  
if (gameOn) {
    ballX=ballX+xSpeed; 
    ballY=ballY-ySpeed;
  }else{
    ballX =1095; 
    ballY = 540;
    }
  }



void checkWall(){ 
  
  // check if ball hit top and bottom, then make it bounce

  if ((ballY+radius <= 0) ||
    (ballY+radius)  >= screenHeight) {
    ySpeed=ySpeed * -1;  //reverse direction
  }
  
// check if ball hit right & left wall and increment score accordingly
if ((ballX+radius) >= screenWidth) {
    xSpeed=5;
    gameOn=false;
    
    //move ball back to center 
    ballX =1095; 
    ballY = 540;
   leftScore=leftScore+1;  //increment leftscore player by +1
    }
  else if ((ballX-radius <= 0)) {
    xSpeed=5;
    gameOn=false;
    
    //move ball back to center 
    ballX =1095; 
    ballY = 540;
    rightScore=rightScore+1;  //increment right score player by +1
}
  }
  


  void displayScores(){
    
  fill(239,98,38);  // Sets the colour of the scores orange 
  textSize(sizeNum);  //sets the text size to 70
  text(leftScore,player1X,player1Y2Y);  // sets the  score for the left player
  text(rightScore,player2X,player1Y2Y);  //sets the score for  the right player
  }

  //check if mouse is pressed, set gameOn to true
  boolean setGameMode(){
    
  if (mousePressed) {
    gameOn=true;
    }
    return gameOn;
}


  


  
 
  

  //Checks if ball overlaps paddle
boolean doesOverlap(float paddleX, float paddleY, float widthOfPaddles, float heightOfPaddles, float ballX, float ballY, float radius) {
  float leftBallEdge = ballX-radius; //left edge of ball
  float bottomBallEdge = ballY+radius; //bottom edge of ball
  float rightBallEdge = ballX+radius; //right edge of ball
  float topBallEdge = ballY-radius; //top edge of ball

  float leftPaddleEdge = paddleX; //left edge of paddle
  float bottomPaddleEdge = paddleY+heightOfPaddles; //bottom edge of paddle
  float rightPaddleEdge = paddleX+widthOfPaddles; //right edge of paddle
  float topPaddleEdge = paddleY; //top edge of paddle

  if (bottomBallEdge >= topPaddleEdge //Check if bottom edge of ball and top edge of paddle overlap
    && topBallEdge <= bottomPaddleEdge //Check if top edge of ball and bottom edge of paddle overlap
    && leftBallEdge <= rightPaddleEdge //Check if left edge of ball and right edge of paddle overlap
    && rightBallEdge >= leftPaddleEdge ) //Check if right edge of ball and left edge of paddle overlap
  {   
    return true;
  } else { 
 return false;
  }
}