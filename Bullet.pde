class Bullet extends GameObject
{
  color c;
  float x, y;
  
  Bullet(float angle, float speed, boolean f)
  {
    gunAngle = angle;
    this.speed = speed;
    h = 2;
    w = 10;
    friendly = f;
  }
  
  void render()
  {
    stroke(c);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(gunAngle);
    rect(0, 0, w, h);
    popMatrix();    
  }
  
  void update()
  {
    if(gunAngle < 0)
    {
      y = -2.0f;
    }
    else if(gunAngle > 0)
    {
      y = 2.0f;
    }
    else
    {
      y = 0.0f;
    }
    x = speed;
    forward = new PVector(x, y);
    pos.add(forward);
    
    if (pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height)
    {
      //remove bullet
      gameObjects.remove(this);
    }
  }
}
