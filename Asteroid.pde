class Asteroid extends GameObject
{
  float numX, numY;
  float theta;
  
  Asteroid()
  {
    w = 50;
    h = 50;
    pos.x = width + 100;
    pos.y = random(h, height - h);
    initial = new PVector(0, 0);
    speed = 2.0f;
    theta = 0.0f;
  }
  
  void render()
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
  
  void update()
  {
    pos.x -= speed;
    if (pos.x < -(w * 0.5f))
    {
      gameObjects.remove(this);
    }
  }
}
