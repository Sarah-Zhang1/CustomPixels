//PImage furElise;
PImage christmasMusic;
// 47x50 pixels
PixelTile[][] tiles; // Modify to 2D array to hold grid of tiles
int cols;
int rows;

int tileWidth = 47; 
int tileHeight = 50; 

void setup() {
  size(612, 601);
  christmasMusic = loadImage("HarbissonChristmas.png"); // Make sure this file is in the data folder

  int w = christmasMusic.width;
  int h = christmasMusic.height;

  // Calculate the number of tiles horizontally and vertically
  cols = w / tileWidth;
  rows = h / tileHeight;

  tiles = new PixelTile[cols][rows]; // Initialize the 2D array

  loadPixels(); // Load the pixel data of the display window into the pixels[] array
  christmasMusic.loadPixels(); // Load the pixel data of the image into the pixels[] array


  //For finding a font
  //String[] fontList = PFont.list();
  //printArray(fontList);

  // Extract and process each tile
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int[] tilePixels = extractTilePixels(i * tileWidth, j * tileHeight, tileWidth, tileHeight);
      tiles[i][j] = new PixelTile(tilePixels);
    }
  }

  drawAverageBWTiles(cols, rows);
}

void draw() {
  if (key == 'b') {
    drawAverageBWTiles(cols, rows);
  } else if (key == 'c') {  
    drawAverageColorTiles(cols, rows);
  } else if (key == 'o') { 
    image(christmasMusic, 0, 0);
  } else if (key == 'p') { 
    
  } 
}

int[] extractTilePixels(int startX, int startY, int tileWidth, int tileHeight) {
  int[] tilePixels = new int[tileWidth * tileHeight];
  int index = 0;
  for (int y = startY; y < startY + tileHeight; y++) {
    for (int x = startX; x < startX + tileWidth; x++) {
      int pixelIndex = y * christmasMusic.width + x;
      tilePixels[index++] = christmasMusic.pixels[pixelIndex];
    }
  }
  return tilePixels;
}


void drawAverageColorTiles(int cols, int rows) {
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


void drawAverageBWTiles(int cols, int rows) {
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
