class Boid {
  
  int index;
  PVector pos, vel, acc;
  float maxForce, maxSpeed;
  
  int state;
  float size;
  int[] nearCellIndex = new int[3];
  PVector nearCellPos;
  
  Trail trail;
  
  Boid(PVector _pos, int _index) {
    
    pos = _pos;
    vel = PVector.random3D();
    vel.setMag(random(2, 4));
    acc = new PVector();
    maxForce = 0.2;
    maxSpeed = 3;
    index = _index;
    
    trail = new Trail(trailSize);
    
    updateNearCell();
  }
  
  void checkBound() {
    
    if (pos.x > sizeX) {
      pos.x = 0;
      trail = new Trail(trailSize);
    } else if (pos.x < 0) {
      pos.x = sizeX;
      trail = new Trail(trailSize);
    }
    if (pos.y > sizeY) {
      pos.y = 0;
      trail = new Trail(trailSize);
    } else if (pos.y < 0) {
      pos.y = sizeY;
      trail = new Trail(trailSize);
    }
    if (pos.z > sizeZ) {
      pos.z = 0;
      trail = new Trail(trailSize);
    } else if (pos.z < 0) {
      pos.z = sizeZ;
      trail = new Trail(trailSize);
    }
  }
  
  PVector align(Boid[] boidTab) {
   
    float lookRad = 25;
    PVector steer = new PVector();
    int total = 0;
    
    for(Boid b : boidTab) {
    
      float d = dist(pos.x, pos.y, pos.z, b.pos.x, b.pos.y, b.pos.z);
      if(b != this && d < lookRad) {
        
        steer.add(b.vel);
        total++;
      }
    }
    
    if (total > 0) {
      
      steer.div(total);
      steer.setMag(maxSpeed);
      steer.sub(vel);
      steer.limit(maxForce);
    }
    
    return steer;
  }
  
  PVector separation(Boid[] boidTab) {
    
    float lookRad = 25;
    PVector steer = new PVector();
    int total = 0;
    
    for(Boid b : boidTab) {
      
      float d = dist(pos.x, pos.y, pos.z, b.pos.x, b.pos.y, b.pos.z);
      if(b != this && d < lookRad) {
        
        PVector b2 = PVector.sub(pos, b.pos);
        b2.div(d * d);
        steer.add(b2);
        total++;
      }
    }
    
    if (total > 0) {
      
      steer.div(total);
      steer.setMag(maxSpeed);
      steer.sub(vel);
      steer.limit(maxForce);
    }
    
    return steer;
  }
    
  PVector cohesion(Boid[] boidTab) {
    
    float lookRad = 25;
    PVector steer = new PVector();
    int total = 0;
    
    for(Boid b : boidTab) {
      
      float d = dist(pos.x, pos.y, pos.z, b.pos.x, b.pos.y, b.pos.z);
      if (b != this && d < lookRad) {
        steer.add(b.pos);
        total++;
      }
    }
    if (total > 0) {
      
      steer.div(total);
      steer.sub(pos);
      steer.setMag(maxSpeed);
      steer.sub(vel);
      steer.limit(maxForce);
    }
    
    return steer;
  }
  
  void flock(Boid[] boidTab) {
    
    PVector alignV = this.align(boidTab);
    PVector cohesionV = this.cohesion(boidTab);
    PVector separationV = this.separation(boidTab);
    
    alignV.mult(align);
    cohesionV.mult(cohesion);
    separationV.mult(sep);
    
    acc.add(alignV);
    acc.add(cohesionV);
    acc.add(separationV);
  }
  
  void update() {
    
    pos.add(vel);
    vel.add(acc);
    //vel.mult(state * density * 10 + .2);
    vel.limit(maxSpeed);
    vel.limit(maxSpeedRef);
    acc.mult(0);
    
    if(state == 2 || state == 5) maxSpeed++;
    if(state == 1 || state == 7) {
      maxSpeed--;
      if (maxSpeed < minSpeedRef) maxSpeed = minSpeedRef;
    }
    
    trail.update(pos);
    updateNearCell();
  }
  
  void updateNearCell() {
    
    int nbS = int(sizeX * density);
    int sS = sizeX/nbS;
    nearCellIndex[0] = abs(floor(pos.x/sS) % gridSizeX);
    float newX = pos.x - pos.x%sS + sS * .5;
    
    nbS = int(sizeY * density);
    sS = sizeY/nbS;
    nearCellIndex[1] = abs(floor(pos.y/sS) % gridSizeY);
    float newY = pos.y - pos.y%sS + sS * .5;
    
    nbS = int(sizeZ * density);
    sS = sizeZ/nbS;
    nearCellIndex[2] = abs(floor(pos.z/sS) % gridSizeZ);
    float newZ = pos.z - pos.z%sS + sS * .5;
    
    nearCellPos = new PVector(newX, newY, newZ);
    
    state = ca.grid[nearCellIndex[0]][nearCellIndex[1]][nearCellIndex[2]];
  }
  
  void display() {
    
    size = 2 + state * 2;
    
    if (state == 6 || state == 0) stroke(h - 30, 60, 120);
    else if (state == 3 || state == 8) {
      size = state * 2;
      stroke(h, 5, 200);
    }
    else stroke(h, 70, 170);
    
    pushMatrix();
    translate(
        (noise(pos.x * noiseRatioX_b * .1 + state) - .5) * noiseAmp_b, 
        (noise(pos.y * noiseRatioY_b * .1 + state) - .5) * noiseAmp_b,
        (noise(pos.z * noiseRatioZ_b * .1 + state) - .5) * noiseAmp_b);
    
    translate(pos.x * (warpX - 1), pos.y * (warpY - 1), pos.z * (warpZ - 1));    
    
    size *= boidsScale; 
    strokeWeight(size);
    
    point(pos.x, pos.y, pos.z);
    trail.display();
    popMatrix();
  }
}
