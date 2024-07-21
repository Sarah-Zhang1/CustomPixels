// represents a new pixel that stores the r, g, b values of a section of "normal" pixels 
class PixelTile {
  int[] reds;
  int[] greens;
  int[] blues;

  //constructor 
  PixelTile(int[] p) {
    // initializes the r,g,b arrays
    reds = new int[p.length];
    greens = new int[p.length];
    blues = new int[p.length];

    // Iterate through every pixel in the tile to store the r, g,b values
    for (int i = 0; i < p.length; i++) {
      color c = p[i];
      reds[i] = (int)red(c);
      greens[i] = (int)green(c);
      blues[i] = (int)blue(c);
    }
  }


  //calculates and returns the average black/white value
  int calcAverageBW() {
    float bw = 0.299 * calcAverage(reds) + 0.587 * calcAverage(greens) + 0.114 * calcAverage(blues);

    return (int)bw;
  }

  //calculates and returns the average red value
  int calcAverageRed() {
    return calcAverage(reds);
  }

  //calculates and returns the average green value
  int calcAverageGreen() {
    return calcAverage(greens);
  }

  //calculates and returns the average blue value
  int calcAverageBlue() {
    return calcAverage(blues);
  }

  //calculates the average value from the given array 
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
