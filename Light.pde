class Light extends GameObject
{
  color c;
  float theta;
  
  Light()
  {
    w = 20;
    h = 20;
    pos.x = width + w;
    pos.y = random((height * 0.2f) + h, (height * 0.8f) - h);
    speed = 2.0f;
    c = color(255, 0, 0);
    theta = 0.0f;
  }
  
  void render()
  {
    stroke(c);
    fill(c);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    triangle(0, 0, -w, -h, w, -h);
    popMatrix();
    stroke(0);
    ellipse(pos.x, pos.y, w, h);
    
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
