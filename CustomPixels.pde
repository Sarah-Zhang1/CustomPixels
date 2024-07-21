import processing.sound.*;

//Sound files
SoundFile christmas;
SoundFile destroyers; 
SoundFile lisa; 
SoundFile bigBand; 

//Image files
PImage christmasMusic;
PImage destroyersImage;
PImage lisaImage;
PImage bigBandImage;

//2D array holding PixelTiles for each image 
PixelTile[][] christmasTiles;
PixelTile[][] destroyersTiles;
PixelTile[][] lisaTiles;
PixelTile[][] bigBandTiles;

//# of columns and rows of PixelTiles
int cols;
int rows;

int tileWidth;
int tileHeight;

int w; 
int h; 

void setup() {
  size(612, 601);
  
  //import images
  christmasMusic = loadImage("HarbissonChristmas.jpg");
  destroyersImage = loadImage("destroyersImage.jpg");
  lisaImage = loadImage("LisaLisaRecord.jpg");
  bigBandImage = loadImage("BigBand.jpg");
  
  //import sound files
  christmas = new SoundFile(this, "ChristmasDoYouHear.mp3");
  destroyers = new SoundFile(this, "Ravers.mp3"); 
  lisa = new SoundFile(this, "LisaLisa.mp3");
  bigBand = new SoundFile(this, "BigBandSound.mp3");


  w = destroyersImage.width;
  h = destroyersImage.height;

  // Calculate the tile size. should be a 13 x 12 grid of PixelTiles
  tileWidth = 47;
  tileHeight = 50;

  // Calculate the number of tiles horizontally and vertically
  cols = w / tileWidth;
  rows = h / tileHeight;

  //initialize 2-D arrays 
  christmasTiles = new PixelTile[cols][rows];
  destroyersTiles = new PixelTile[cols][rows];
  lisaTiles = new PixelTile[cols][rows];
  bigBandTiles = new PixelTile[cols][rows];

  //load in pixels for imported images
  loadPixels();
  christmasMusic.loadPixels();
  destroyersImage.loadPixels();
  lisaImage.loadPixels();
  bigBandImage.loadPixels();

  // converts sections of pixels from an image to a pixel tile 
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int[] christmasTilePixels = extractTilePixels(i * tileWidth, j * tileHeight, christmasMusic.pixels);
      christmasTiles[i][j] = new PixelTile(christmasTilePixels);

      int[] destroyersTilePixels = extractTilePixels(i * tileWidth, j * tileHeight, destroyersImage.pixels);
      destroyersTiles[i][j] = new PixelTile(destroyersTilePixels);

      int[] lisaTilePixels = extractTilePixels(i * tileWidth, j * tileHeight, lisaImage.pixels);
      lisaTiles[i][j] = new PixelTile(lisaTilePixels);

      int[] bigBandTilePixels = extractTilePixels(i * tileWidth, j * tileHeight, bigBandImage.pixels);
      bigBandTiles[i][j] = new PixelTile(bigBandTilePixels);
    }
  }

  background(255);
  
  //create a 4x4 grid of the imported original images
  image(christmasMusic, 0, 0, w/2, h/2); 
  image(destroyersImage, 0, height / 2, w/2, h/2); 
  image(lisaImage, width / 2, height / 2, w/2, h/2); 
  image(bigBandImage, width / 2, 0, w/2, h/2); 
  
  
  frameRate(2);
}

void draw() {
  // selects a random number between 0 and 1 inclusive to decide whether to 
  // display the color or the black and white version 
  float rand_num = (int) random(0, 2);
  
  //depending on the key that the user presses it shows one of the images in 
  //pixeled form as well as playing that music thats labelled on the record 
  if (key == '1') {
    if (rand_num == 0) {
      drawAverageBWTiles(cols, rows, christmasTiles);
    } else {
      drawAverageColorTiles(cols, rows, christmasTiles);
    }
    //play the song thats on the christmas music image record and stop any other 
    //songs that are playing 
    destroyers.stop();
    lisa.stop();
    bigBand.stop();
    if (!christmas.isPlaying()) {
      christmas.play();
    }
  } else if (key == '2') {
    if (rand_num == 0) {
      drawAverageBWTiles(cols, rows, destroyersTiles);
    } else {
      drawAverageColorTiles(cols, rows, destroyersTiles);
    }
    
    //play the song thats on the destroyer image record and stop any other 
    //songs that are playing 
    lisa.stop();
    christmas.stop();
    bigBand.stop();
    if (!destroyers.isPlaying()) {
      destroyers.play();
    }
  } else if (key == '3') {
    if (rand_num == 0) {
      drawAverageBWTiles(cols, rows, lisaTiles);
    } else {
      drawAverageColorTiles(cols, rows, lisaTiles);
    }
    //play the song thats on the lisa lisa image record and stop any other 
    //songs that are playing 
    destroyers.stop();
    christmas.stop();
    bigBand.stop();
    if (!lisa.isPlaying()) {
      lisa.play();
    }
  } else if (key == '4'){ 
    if (rand_num == 0) {
      drawAverageBWTiles(cols, rows, bigBandTiles);
    } else {
      drawAverageColorTiles(cols, rows, bigBandTiles);
    }
    //play the song thats on the big band era image record and stop any other 
    //songs that are playing 
    destroyers.stop();
    christmas.stop();
    lisa.stop();
    if (!bigBand.isPlaying()) {
      bigBand.play();
    }
  }
}

//returns an array with a certain section of pixels from the given list of pixels of the original image 
int[] extractTilePixels(int startX, int startY, int[] p) {
  int[] tilePixels = new int[tileWidth * tileHeight];
  int index = 0;
  for (int y = startY; y < startY + tileHeight; y++) {
    for (int x = startX; x < startX + tileWidth; x++) {
      int pixelIndex = y * w + x;
      tilePixels[index++] = p[pixelIndex];
    }
  }
  return tilePixels;
}

//draws the colored version of the PixelTile where it shows the r,g,b values 
void drawAverageColorTiles(int cols, int rows, PixelTile[][] tiles) {
  background(0);
  PFont f = createFont("Verdana-Bold", 10);
  textAlign(CENTER, CENTER);
  textFont(f);
  
  // iterates through the grid of PixelTiles
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // calculates the average r,g,b value of the pixels stores in the PixelTile
      int avgRed = tiles[i][j].calcAverageRed();
      int avgGreen = tiles[i][j].calcAverageGreen();
      int avgBlue = tiles[i][j].calcAverageBlue();

      //displays the tile 
      color c = color(avgRed, avgGreen, avgBlue);
      color transparentC = color(avgRed, avgGreen, avgBlue, 210);
      String avgText = "R:" + avgRed + "\n G:" + avgGreen + "\n B:" + avgBlue;
      fill(transparentC);
      rect(i * tileWidth, j * tileHeight, tileWidth, tileHeight);
      fill(c);
      text(avgText, i * tileWidth + tileWidth / 2, j * tileHeight + tileHeight / 2);
    }
  }
}

//draws the black and white version of the PixelTile 
void drawAverageBWTiles(int cols, int rows, PixelTile[][] tiles) {
  background(0);
  PFont f = createFont("Verdana-Bold", 10);
  textAlign(CENTER, CENTER);
  textFont(f);
  
  // iterates through the grid of PixelTiles
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // calculates the average black/white value of the pixels stores in the PixelTile
      int avg = tiles[i][j].calcAverageBW();

      //displays the tile 
      color c = color(avg);
      color transparentC = color(avg, 220);
      fill(transparentC);
      rect(i * tileWidth, j * tileHeight, tileWidth, tileHeight);
      fill(c);
      text(str(avg), i * tileWidth + tileWidth / 2, j * tileHeight + tileHeight / 2);
    }
  }
}
