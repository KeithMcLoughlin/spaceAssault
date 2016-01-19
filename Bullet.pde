class Bullet extends GameObject
{
  color c;
  int bulletSize;
  float x, y;
  
  Bullet(float angle)
  {
    gunAngle = angle;
    speed = 8.0f;
    bulletSize = 8;
  }
  
  void render()
  {
    stroke(c);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(gunAngle);
    line(-bulletSize, 0, bulletSize, 0);
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
