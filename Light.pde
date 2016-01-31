class Light extends GameObject
{
  color c;
  float theta;
  
  Light()
  {
    w = 20;
    h = 20;
    pos.x = width + w;
    pos.y = height * 0.4f;
    speed = 2.0f;
    c = color(255, 0, 0);
    theta = 0.0f;
  }
  
  void render()
  {
    stroke(c, 126);
    fill(c, 126);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    triangle(0, 0, -w, -(h * 2.0f), w, -(h * 2.0f));
    triangle(0, 0, -w, h * 2.0f, w, h * 2.0f);
    popMatrix();
    stroke(0);
    fill(c);
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
