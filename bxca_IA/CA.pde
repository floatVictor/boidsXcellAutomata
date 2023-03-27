class CA {
  
  int[][][] grid;
  
  CA() {
    grid = new int[gridSizeX][gridSizeY][gridSizeZ];
    // initialize grid randomly
    for (int i = 0; i < gridSizeX; i++) {
      for (int j = 0; j < gridSizeY; j++) {
        for (int k = 0; k < gridSizeZ; k++) {
          //grid[i][j][k] = int(random(n));
          grid[i][j][k] = int(nbStates * noise(
              (i + frameCount) * noiseRatioX_ca, 
              (j + frameCount) * noiseRatioY_ca, 
              (k + frameCount) * noiseRatioZ_ca));
        }
      }
    }
  }
  
  void update() {
    for (int i = 0; i < gridSizeX; i++) {
      for (int j = 0; j < gridSizeY; j++) {
        for (int k = 0; k < gridSizeZ; k++) {
          int state = grid[i][j][k];
          grid[i][j][k] = (state + 1) % nbStates;
          //println( grid[i][j][k]);
        }
      }
    }
  }
  
  void display() {
    // draw cells
    for (int i = 0; i < gridSizeX; i++) {
      for (int j = 0; j < gridSizeY; j++) {
        for (int k = 0; k < gridSizeZ; k++) {
          int state = grid[i][j][k];
          stroke(color(state * 255 / (nbStates-1)), cellOpa);
          strokeWeight(cellSize);
          pushMatrix();
          translate(
        (noise((i / density) * noiseRatioX_b * .1 + state) - .5) * noiseAmp_b, 
        (noise((j / density) * noiseRatioY_b * .1 + state) - .5) * noiseAmp_b,
        (noise((k / density) * noiseRatioZ_b * .1 + state) - .5) * noiseAmp_b);
          translate(
              (i / density) * (warpX), 
              (j / density) * (warpY), 
              (k / density) * (warpZ));
          point(0, 0, 0);
          popMatrix();
        }
      }
    }
  }
}
