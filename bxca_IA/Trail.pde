class Trail {
  
  PVector[] trail;
  int trailSize;
  int trailIndex;
  color trailColor;
  
  Trail(int size) {
    
    trailSize = size;
    trail = new PVector[trailSize];
    trailIndex = 0;
  }
  
  void update(PVector pos) {
    
    trail[trailIndex] = pos.copy();
    trailIndex++;
    
    if (trailIndex >= trailSize) {
      trailIndex = 0;
    }
  }
  
  void display() {
    
    strokeWeight(1);
    noFill();
    push();
    beginShape();
    
    for (int i = 0; i < trailSize; i++) {
      if (trail[i] != null) {
        vertex(trail[i].x, trail[i].y, trail[i].z);
      }
    }
    endShape();
    pop();
  }
}
