class ParticleSystem {
  ArrayList<Particle> particles;
  int gridH;
  int gridW;

  PShape particleShape;

  ParticleSystem(int n) {
    particles = new ArrayList<Particle>();
    particleShape = createShape(PShape.GROUP);
    
    
    for (int i = 0; i < n; i++) {
      Particle p = new Particle();
      particles.add(p);
      particleShape.addChild(p.getShape());
    }
    
    double CR = Math.cbrt(n);
    gridH = (int)  Math.ceil(CR);
    gridW = 2*gridH;
    
  }

  void update() {
    for (Particle p : particles) {
      p.update();
    }
  }

void setEmitter(float x, float y) {
  int index = 0;
  for (Particle p : particles) {
    int col = index % gridW;
    int row = index / gridW;

    float cellX = map(col, 0, gridW - 1, 100, width - 100);
    float cellY = map(row, 0, gridH - 1, 100, height - 100);

    p.setTarget(cellX, cellY);
    index++;
  }
}
  void addParticles(int n) {

 for (int i = 0; i < n; i++) {
    Particle p = new Particle();
    p.rebirth(mouseX, mouseY);  // Set initial position
    particles.add(p);
    particleShape.addChild(p.getShape());
  }
  println("added " + n + " particles");


  }


  //helper func to clear particles
  void reset() {
   println("resetting particles");
  particles.clear();
  particleShape = createShape(PShape.GROUP);  // Clear old shape group
  }


  void display() {

    shape(particleShape);
  }
}
