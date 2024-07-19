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


  int calcAverageBW() {
    float bw = 0.299 * calcAverage(reds) + 0.587 * calcAverage(greens) + 0.114 * calcAverage(blues);


    return (int)bw;
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
