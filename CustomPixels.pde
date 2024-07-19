//PImage furElise;
PImage christmasMusic;
// 47x50 pixels
PixelTile[][] tiles; // Modify to 2D array to hold grid of tiles

void setup() {
  size(600, 600);
  christmasMusic = loadImage("HarbissonChristmas.png"); // Make sure this file is in the data folder

  int w = christmasMusic.width;
  int h = christmasMusic.height;
  
  // Calculate the number of tiles horizontally and vertically
  int cols = w / 47;
  int rows = h / 50;
  
  tiles = new PixelTile[cols][rows]; // Initialize the 2D array

  image(christmasMusic, 0, 0);
  noLoop(); // Stop draw() from looping, since we only need to process the image once

  loadPixels(); // Load the pixel data of the display window into the pixels[] array
  christmasMusic.loadPixels(); // Load the pixel data of the image into the pixels[] array
  
  // Extract and process each tile
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int[] tilePixels = extractTilePixels(i * 47, j * 50, 47, 50);
      tiles[i][j] = new PixelTile(tilePixels);
    }
  }
  
  background (255); 
  
  // Redraw the image using the average colors of the tiles
  drawAverageTiles(cols, rows);
 
  
}

void draw() {
  
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


void drawAverageTiles(int cols, int rows) { 
  PFont f = createFont("Arial-Bold", 10);
  textAlign(CENTER, CENTER);
  textFont(f);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int avgRed = tiles[i][j].calcAverageRed();
      int avgGreen = tiles[i][j].calcAverageGreen();
      int avgBlue = tiles[i][j].calcAverageBlue();
      
      color c = color(avgRed, avgGreen, avgBlue); 
      color transparentC = color(avgRed, avgGreen, avgBlue, 127);
      String avgText = "R:" + avgRed + "\n G:" + avgGreen + "\n B:" + avgBlue;
      fill(transparentC); 
      rect(i * 47, j * 50, 47, 50);
      fill(c); 
      text(avgText, i * 47 + 23.5, j * 50 + 25);
    }
  }
}

class PixelTile {
  int[] reds;
  int[] greens;
  int[] blues;

  PixelTile(int[] p) {
    // Create arrays to hold the RGB values
    reds = new int[p.length];
    greens = new int[p.length];
    blues = new int[p.length];

    // Iterate through every pixel in the tile
    for (int i = 0; i < p.length; i++) {
      color c = p[i];
      reds[i] = (int)red(c);
      greens[i] = (int)green(c);
      blues[i] = (int)blue(c);
    }
  }

  int calcAverageRed() {
    return calcAverage(reds); 
  }
  
  int calcAverageGreen() {
    return calcAverage(greens); 
  }
  
  int calcAverageBlue() {
    return calcAverage(blues); 
  }
  
  int calcAverage(int[] p) {
    int sum = 0; 
    int num = 0; 
    for (int i = 0; i < p.length; i++) { 
      sum += p[i]; 
      num++;
    }
    return sum / num; 
  }
}
