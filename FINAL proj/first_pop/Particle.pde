class Particle {
  PVector target;
  PVector velocity;
  float lifespan = 255;
  // PVector location;
  PVector position;
  PVector acceleration;
  
  PShape part;
  float partSize;
  
  PVector gravity = new PVector(0,0.1);


  Particle() {
    partSize = random(10,60);
    part = createShape();
    part.beginShape(QUAD);
    part.noStroke();
    part.texture(sprite);
    part.normal(0, 0, 1);
    part.vertex(-partSize/2, -partSize/2, 0, 0);
    part.vertex(+partSize/2, -partSize/2, sprite.width, 0);
    part.vertex(+partSize/2, +partSize/2, sprite.width, sprite.height);
    part.vertex(-partSize/2, +partSize/2, 0, sprite.height);
    part.endShape();
    
    rebirth(width/2,height/2);
    //lifespan = random(255);
  }

  PShape getShape() {
    return part;
  }



void setTarget(float x, float y) {
  target = new PVector(x, y);
}

  
  void rebirth(float x, float y) {
    
                              position = new PVector(x, y);
                          velocity = new PVector(0, 0);
                          target = null; 
    //float a = random(TWO_PI);
    //float speed = random(0.5,4);
    //velocity = new PVector(cos(a), sin(a));
    //velocity.mult(speed);
    //lifespan = 255;   
    //part.resetMatrix();
    //part.translate(x, y); 
  }
  
  boolean isDead() {
    if (lifespan < 0) {
     return true;
    } else {
     return false;
    } 
  }
              void moveToTarget(PVector target) {
              PVector desired = PVector.sub(target, position);
              desired.mult(0.05);  // The strength/speed of movement
            
              velocity.add(desired);
              velocity.limit(3); // Optional speed limit
              position.add(velocity);
              
              getShape().resetMatrix();
              getShape().translate(position.x, position.y);
            }
            

//  public void update() {
//    lifespan = lifespan - 1;
//    //velocity.add(gravity);
    
//    part.setTint(color(255,lifespan));
//    part.translate(velocity.x, velocity.y);
//  }
//}




void update() {
  if (target != null) {
    PVector desired = PVector.sub(target, position);
    desired.mult(0.05);  // Movement strength
    velocity.add(desired);
    velocity.limit(3);
    position.add(velocity);

    getShape().resetMatrix();
    getShape().translate(position.x, position.y);
  }
}
}
