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
    // get the cube root of each particle system set. Grid width is 2* cube root and height is cube root. (creating a 2X1 ratio grid)
    double CR = Math.cbrt(n);
    // round up
    gridH = (int)  Math.ceil(CR);
    gridW = 2*gridH;
  }

  void update() {
    for (Particle p : particles) {
      // PARTICLE update
      p.update();
    }
  }

  void setEmitter(float x, float y) {

    // code for this function references this tutorial
    // https://medium.com/@rh.h.rad/19-chaos-to-grid-generative-particle-animation-in-processing-7c44f9a0e023
    int index = 0;
    for (Particle p : particles) {
      int col = index % gridW;
      int row = index / gridW;

      float cellX = map(col, 0, gridW - 1, 200, width - 100)- 100;
      float cellY = map(row, 0, gridH - 1, 200, height - 100) - 100;


      p.setTarget(cellY, cellX);
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
    //println("resetting particles");
    //particles.clear();
    //particleShape = createShape(PShape.GROUP);  // Clear old shape group
  }


  void display() {

    shape(particleShape);
  }
  
  


void centerTarget(float x, float y){
 for (Particle p : particles) {
     p.setTarget(x, y);
 }
}

}
