class Asteroid extends GameObject implements  Enemy
{
  float numX, numY;
  float theta;
  
  Asteroid()
  {
    w = 50;
    h = 50;
    pos.x = width + w;
    pos.y = random(h, height - h);
    initial = new PVector(0, 0);
    speed = 2.0f;
    theta = 0.0f;
    health = 2;
    alive = true;
  }
  
  void render()
  {
    if(alive)
    {
      stroke(0);
      initial.x = -(w * 0.5f);
      initial.y = -(h * 0.5f);
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(theta);
      fill(#5A5C64);
      beginShape();
      vertex(initial.x, initial.y);
      vertex(initial.x + (w * 0.3f), initial.y + (h * 0.1f));
      vertex(initial.x + (w * 0.6f), initial.y + (h * 0.2f));
      vertex(initial.x + w, initial.y + (h * 0.5f));
      vertex(initial.x + (w * 0.5f), initial.y + h);
      vertex(initial.x + (w * 0.2f), initial.y + h);
      vertex(initial.x, initial.y + (h * 0.6f));
      endShape(CLOSE);
      popMatrix();
      theta += 0.1f;
    }
    else
    {
      strokeWeight(5);
      noFill();
      stroke(#FFCD15);
      explosionRadius += 8.0f;
      ellipse(pos.x, pos.y, explosionRadius, explosionRadius);
      strokeWeight(1);
      if(explosionRadius > (w * 2.0f))
      {
        gameObjects.remove(this);
      }
    }
  }
  
  void update()
  {
    pos.x -= speed;
    if (pos.x < -(w * 0.5f))
    {
      gameObjects.remove(this);
    }
  }
}
