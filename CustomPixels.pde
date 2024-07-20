//PImage furElise;
PImage christmasMusic;
PImage millionDollar;
PImage musicalHeritage;
PImage autumnLeaves;

// 47x50 pixels
PixelTile[][] christmasTiles; // 2D array holding the tiles for the christmas music image
PixelTile[][] millionTiles; // 2D array holding the tiles for the million dollar music image
PixelTile[][] musicalTiles; // 2D array holding the tiles for the musical heritage music image
PixelTile[][] autumnTiles; // 2D array holding the tiles for the autumn leaves music image

int cols;
int rows;

int tileWidth = 47;
int tileHeight = 50;

void setup() {
  size(612, 601);
  christmasMusic = loadImage("HarbissonChristmas.png"); // Make sure this file is in the data folder
  millionDollar = loadImage("MillionDollarLook.jpg");
  musicalHeritage = loadImage("MusicalHeritageSociety.jpg");
  autumnLeaves = loadImage("AutumnLeaves.jpg");

  int w = christmasMusic.width;
  int h = christmasMusic.height;

  // Calculate the number of tiles horizontally and vertically
  cols = w / tileWidth;
  rows = h / tileHeight;

  christmasTiles = new PixelTile[cols][rows];
  millionTiles = new PixelTile[cols][rows];
  musicalTiles = new PixelTile[cols][rows];
  autumnTiles = new PixelTile[cols][rows];

  loadPixels(); // Load the pixel data of the display window into the pixels[] array
  christmasMusic.loadPixels(); // Load the pixel data of the image into the pixels[] array
  millionDollar.loadPixels();
  musicalHeritage.loadPixels();
  autumnLeaves.loadPixels();

  //For finding a font
  //String[] fontList = PFont.list();
  //printArray(fontList);

  // Extract and process each tile
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int[] christmasTilePixels = extractTilePixels(i * tileWidth, j * tileHeight, tileWidth, tileHeight, christmasMusic.pixels);
      christmasTiles[i][j] = new PixelTile(christmasTilePixels);

      int[] millionTilePixels = extractTilePixels(i * tileWidth, j * tileHeight, tileWidth, tileHeight, millionDollar.pixels);
      millionTiles[i][j] = new PixelTile(millionTilePixels);


      int[] musicalTilePixels = extractTilePixels(i * tileWidth, j * tileHeight, tileWidth, tileHeight, musicalHeritage.pixels);
      musicalTiles[i][j] = new PixelTile(musicalTilePixels);

      int[] autumnTilePixels = extractTilePixels(i * tileWidth, j * tileHeight, tileWidth, tileHeight, autumnLeaves.pixels);
      autumnTiles[i][j] = new PixelTile(autumnTilePixels);
    }
  }

  drawAverageBWTiles(cols, rows, christmasTiles);
  frameRate(2);
}

void draw() {
  float rand_num = (int) random(0, 2);
  println(rand_num);
  if (key == '1') {
    if (rand_num == 0) {
      drawAverageBWTiles(cols, rows, millionTiles);
    } else {
      drawAverageColorTiles(cols, rows, millionTiles);
    }
  } else if (key == '2') {
    if (rand_num == 0) {
      drawAverageBWTiles(cols, rows, musicalTiles);
    } else {
      drawAverageColorTiles(cols, rows, musicalTiles);
    }
  } else if (key == '3') {
    if (rand_num == 0) {
      drawAverageBWTiles(cols, rows, autumnTiles);
    } else {
      drawAverageColorTiles(cols, rows, autumnTiles);
    }
  } else { 
    if (rand_num == 0) {
      drawAverageBWTiles(cols, rows, christmasTiles);
    } else {
      drawAverageColorTiles(cols, rows, christmasTiles);
    }
  }
}

int[] extractTilePixels(int startX, int startY, int tileWidth, int tileHeight, int[] p) {
  int[] tilePixels = new int[tileWidth * tileHeight];
  int index = 0;
  for (int y = startY; y < startY + tileHeight; y++) {
    for (int x = startX; x < startX + tileWidth; x++) {
      int pixelIndex = y * christmasMusic.width + x;
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
      rect(i * 47, j * 50, 47, 50);
      fill(c);
      text(avgText, i * 47 + 23.5, j * 50 + 25);
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
      rect(i * 47, j * 50, 47, 50);
      fill(c);
      text(str(avg), i * 47 + 23.5, j * 50 + 25);
    }
  }
}
