import processing.sound.*;

SoundFile christmas;
SoundFile destroyers; 
SoundFile lisa; 
SoundFile bigBand; 

PImage christmasMusic;
PImage destroyersImage;
PImage lisaImage;
PImage bigBandImage;

PixelTile[][] christmasTiles;
PixelTile[][] destroyersTiles;
PixelTile[][] lisaTiles;
PixelTile[][] bigBandTiles;

int cols;
int rows;

int tileWidth;
int tileHeight;

void setup() {
  size(612, 601);
  christmasMusic = loadImage("HarbissonChristmas.jpg");
  destroyersImage = loadImage("destroyersImage.jpg");
  lisaImage = loadImage("LisaLisaRecord.jpg");
  bigBandImage = loadImage("BigBand.jpg");
  
  christmas = new SoundFile(this, "ChristmasDoYouHear.mp3");
  destroyers = new SoundFile(this, "Ravers.mp3"); 
  lisa = new SoundFile(this, "LisaLisa.mp3");
  bigBand = new SoundFile(this, "BigBandSound.mp3");


  int w = christmasMusic.width;
  int h = christmasMusic.height;

  // Calculate the tile size to fit the resized images
  tileWidth = 47;
  tileHeight = 50;

  // Calculate the number of tiles horizontally and vertically
  cols = w / tileWidth;
  rows = h / tileHeight;

  christmasTiles = new PixelTile[cols][rows];
  destroyersTiles = new PixelTile[cols][rows];
  lisaTiles = new PixelTile[cols][rows];
  bigBandTiles = new PixelTile[cols][rows];

  loadPixels();
  christmasMusic.loadPixels();
  destroyersImage.loadPixels();
  lisaImage.loadPixels();
  bigBandImage.loadPixels();

  // Extract and process each tile
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int[] christmasTilePixels = extractTilePixels(i * tileWidth, j * tileHeight, tileWidth, tileHeight, christmasMusic.pixels, w);
      christmasTiles[i][j] = new PixelTile(christmasTilePixels);

      int[] destroyersTilePixels = extractTilePixels(i * tileWidth, j * tileHeight, tileWidth, tileHeight, destroyersImage.pixels, w);
      destroyersTiles[i][j] = new PixelTile(destroyersTilePixels);

      int[] lisaTilePixels = extractTilePixels(i * tileWidth, j * tileHeight, tileWidth, tileHeight, lisaImage.pixels, w);
      lisaTiles[i][j] = new PixelTile(lisaTilePixels);

      int[] bigBandTilePixels = extractTilePixels(i * tileWidth, j * tileHeight, tileWidth, tileHeight, bigBandImage.pixels, w);
      bigBandTiles[i][j] = new PixelTile(bigBandTilePixels);
    }
  }

  background(255);
  
  image(christmasMusic, 0, 0, w/2, h/2); 
  image(destroyersImage, 0, height / 2, w/2, h/2); 
  image(lisaImage, width / 2, height / 2, w/2, h/2); 
  image(bigBandImage, width / 2, 0, w/2, h/2); 
  frameRate(2);
}

void draw() {
  float rand_num = (int) random(0, 2);
  println(rand_num);
  if (key == '1') {
    if (rand_num == 0) {
      drawAverageBWTiles(cols, rows, christmasTiles);
    } else {
      drawAverageColorTiles(cols, rows, christmasTiles);
    }
    destroyers.stop();
    lisa.stop();
    christmas.play(); 
  } else if (key == '2') {
    if (rand_num == 0) {
      drawAverageBWTiles(cols, rows, destroyersTiles);
    } else {
      drawAverageColorTiles(cols, rows, destroyersTiles);
    }
    lisa.stop();
    christmas.stop(); 
    destroyers.play();
  } else if (key == '3') {
    if (rand_num == 0) {
      drawAverageBWTiles(cols, rows, lisaTiles);
    } else {
      drawAverageColorTiles(cols, rows, lisaTiles);
    }
    destroyers.stop();
    christmas.stop(); 
    lisa.play();
  } else if (key == '4'){ 
    if (rand_num == 0) {
      drawAverageBWTiles(cols, rows, bigBandTiles);
    } else {
      drawAverageColorTiles(cols, rows, bigBandTiles);
    }
     bigBand.play(); 
  }
}

int[] extractTilePixels(int startX, int startY, int tileWidth, int tileHeight, int[] p, int imageWidth) {
  int[] tilePixels = new int[tileWidth * tileHeight];
  int index = 0;
  for (int y = startY; y < startY + tileHeight; y++) {
    for (int x = startX; x < startX + tileWidth; x++) {
      int pixelIndex = y * imageWidth + x;
      tilePixels[index++] = p[pixelIndex];
    }
  }
  return tilePixels;
}

void drawAverageColorTiles(int cols, int rows, PixelTile[][] tiles) {
  background(0);
  PFont f = createFont("Verdana-Bold", 10);
  textAlign(CENTER, CENTER);
  textFont(f);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int avgRed = tiles[i][j].calcAverageRed();
      int avgGreen = tiles[i][j].calcAverageGreen();
      int avgBlue = tiles[i][j].calcAverageBlue();

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

void drawAverageBWTiles(int cols, int rows, PixelTile[][] tiles) {
  background(0);
  PFont f = createFont("Verdana-Bold", 10);
  textAlign(CENTER, CENTER);
  textFont(f);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int avg = tiles[i][j].calcAverageBW();

      color c = color(avg);
      color transparentC = color(avg, 220);
      fill(transparentC);
      rect(i * tileWidth, j * tileHeight, tileWidth, tileHeight);
      fill(c);
      text(str(avg), i * tileWidth + tileWidth / 2, j * tileHeight + tileHeight / 2);
    }
  }
}
