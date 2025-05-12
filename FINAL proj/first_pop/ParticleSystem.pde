class ParticleSystem {
  ArrayList<Particle> particles;

  PShape particleShape;

  ParticleSystem(int n) {
    particles = new ArrayList<Particle>();
    particleShape = createShape(PShape.GROUP);

    for (int i = 0; i < n; i++) {
      Particle p = new Particle();
      particles.add(p);
      particleShape.addChild(p.getShape());
    }
  }

  void update() {
    for (Particle p : particles) {
      p.update();
    }
  }

  void setEmitter(float x, float y) {
    for (Particle p : particles) {
      if (p.isDead()) {
        p.rebirth(x, y);
      }
    }
  //   for (Particle p : particles) {
  //   p.setEmitterPosition(x, y);
  // }
  }

  void addParticles(int n) {
    for (int i = 0; i < n; i++) {
      particles.add(new Particle());
    }
  }


  //helper func to clear particles
  void reset() {
  particles.clear();
  }


  void display() {

    shape(particleShape);
  }
}
