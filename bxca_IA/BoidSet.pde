class BoidSet {
  
  Boid[] boids;
  
  BoidSet() {
    
    boids = new Boid[nbBoids];
    for (int i = 0; i < boids.length; i++) {
      boids[i] = new Boid(new PVector(random(sizeX), random(sizeY), random(sizeZ)), i);
    }
  }
  
  void update() {
    
    for (Boid b : boids) {
      b.display();
      b.flock(boids);
      b.update();
      b.checkBound();
    }
  }
}
