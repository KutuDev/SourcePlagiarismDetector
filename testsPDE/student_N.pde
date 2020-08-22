//maxX = 480 maxY = 888
float screenWidth=480;
float screenHeight=888;


int bouleX = 240; //Variable pour maintenir la position x de la boule
int bouleY = 444; //Variable pour maintenir la position y de la boule
int bouleWidth = 40; // Variable pour maintenir la largeur de la boule
int bouleHeight = 40; // Variable pour maintenir la hauteur de la boule


   float palGaucheX=0; // Variable pour maintenir la position x de la palette de gauche
   float palGaucheY=0; // Variable pour maintenir la position y de la palette de gauche
   
   float palDroiteX=460; // Variable pour maintenir la position x de la palette de droite
   float palDroiteY=738; // Variable pour maintenir la position Y de la palette de droite
   
   float palWidth=20; // Variable pour maintenir la largeur des deux palettes
   float palHeight=150;// Variable pour maintenir la hauteur des deux palettes
   
 int scoreDroiteX=320;// Variable pour maintenir la position X du score à droite
 int scoreDroiteY=460; // Variable pour maintenir la position Y du score à droite
   
 int scoreGaucheX=160; // Variable pour maintenir la position X du score à gauche
 int scoreGaucheY= 460;// Variable pour maintenir la position Y du score à gauche
 int scoreGauche=0;// Variable du score de gauche
 int scoreDroite=0;// Variable du score de droite
 
       int tailleTexte=45; // Taille du texte
       
       
       int xVitesse=1; // Vitesse horizontale de la boule
       int yVitesse=6; // Vitesse verticale de la boule
       float rayon=20;
       int centreX=240;
       int centreY=444;
       
                      boolean gameOn= false;
                      
                      boolean boulePaletteGauche= false;
                      boolean boulePaletteDroite= false;
void setup() //runs once
{
   
}

void draw() //runs forever
{
  background(0, 255, 255);// Couleur de l'arrière-plan plan 

  mouvementPaletteDroite();
  

  stroke(0,0,255); // Couleur des contours des formes
  fill(0, 128, 0); // Couleur du cercle au centre de l'écran
  ellipse(bouleX, bouleY, bouleWidth, bouleHeight); // Dessin de la boule
  
    
    fill(255,0,0); // Couleur des deux palettes
    rect(palGaucheX,palGaucheY,palWidth,palHeight); // Dessin de la palette en haut à gauche
    rect(palDroiteX, palDroiteY, palWidth, palHeight); // Dessin de la palette en bas à droite
    

  fill(0); // Couleur des scores
  textSize(tailleTexte);// Tailles du texte score
  text(scoreDroite, scoreDroiteX, scoreDroiteY);// Score à droite
  text (scoreGauche,scoreGaucheX,scoreGaucheY);// Score à gauche
  
  
  if(mousePressed){
    gameOn=true;
  }
  
  
  
  //Déplacement de la boule
  if(gameOn){
  bouleX=bouleX-xVitesse;
  bouleY=bouleY+yVitesse;
  }
  
  
 // Si la boule frappe le mur gauche  
if((bouleX-rayon <= 0)) {
  gameOn=false;              // Désactiver le jeu      
  xVitesse=xVitesse*-1;      // Changement de direction
 bouleX=centreX;             // Réinitialiser la position X de la boule au centre
 bouleY=centreY;             // Réinitialiser la position X de la boule au centre
  scoreDroite=scoreDroite+1; // Augmenter le score de droite
  
}

// Si la boule frappe le mur de droite
if((bouleX + rayon) >= screenWidth){
  gameOn=false;              // Désactiver le jeu
  xVitesse=xVitesse*-1;      // Changement de direction
  bouleX=centreX;             // Réinitialiser la position X de la boule au centre
  bouleY=centreY;             // Réinitialiser la position Y de la boule au centre
  scoreGauche=scoreGauche+1; // Augmenter le score de gauche
}

// Si la boule frappe le mur inférieur ou supérieur
if((bouleY-rayon <= 0) || (bouleY + rayon) >=screenHeight) {
  
 yVitesse = yVitesse*-1;  // changer de direction
}

boulePaletteGauche = doesOverlap(palGaucheX, palGaucheY, palWidth, palHeight, bouleX,bouleY,rayon);

if(boulePaletteGauche){
  fill(0);
  xVitesse=xVitesse*-1;
}
boulePaletteDroite= doesOverlap(palDroiteX, palDroiteY, palWidth, palHeight,bouleX,bouleY, rayon);
if(boulePaletteDroite){
  fill(0,255,0);
  xVitesse=xVitesse*-1;
}
}

// Vérifie si la balle chevauche la raquette

boolean doesOverlap (float xPalette, float yPalette, float widthPalette, float heightPalette, float xBoule, float yBoule,float rayon){

 float bouleLeftEdge= xBoule-rayon; // bord gauche de la balle

 float bouleBottomEdge= yBoule+rayon; // bord inférieur de la balle

 float bouleRightEdge= xBoule+rayon; // bord droit de la balle

 float bouleTopEdge= yBoule-rayon; // bord supérieur de la balle

 float paletteLeftEdge= xPalette; // bord gauche de la palette

 float paletteBottomEdge= yPalette+heightPalette; // bord inférieur de la palette

 float paletteRightEdge= xPalette+widthPalette; // bord droit de la palette

 float paletteTopEdge= yPalette; // bord supérieur de la palette

 if(bouleBottomEdge >= paletteTopEdge 
  
 // Vérifier si le bord inférieur de la balle et le bord supérieur de la palette se chevauchent

    && bouleTopEdge <= paletteBottomEdge // Vérifier si le bord supérieur de la balle et le bord inférieur de la palette se chevauchent

    && bouleLeftEdge <= paletteRightEdge // Vérifier si le bord gauche de la balle et le bord droit de la palette se chevauchent

    && bouleRightEdge >= paletteLeftEdge) // Vérifiez si le bord droit de la balle et le bord gauche de la palette se chevauchent

  {  

    return true;

  }else{

    return false;

  }

}




// Déplacement de la palette

void mouvementPaletteDroite(){
  
   palGaucheY=constrain(mouseY,0,screenHeight-palHeight);
   palDroiteY=constrain(mouseX,0,screenHeight-palHeight);
}


