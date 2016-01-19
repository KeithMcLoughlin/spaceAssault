class Bullet extends GameObject
{
  PVector forward;
  color c;
  int bulletSize;
  
  Bullet(float angle)
  {
    gunAngle = angle;
    speed = 8.0f;
    forward = new PVector(0, 0);
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
      forward.y = -2.0f;
    }
    else if(gunAngle > 0)
    {
      forward.y = 2.0f;
    }
    else
    {
      forward.y = 0.0f;
    }
    forward.x = speed;
    pos.add(forward);
    
    if (pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height)
    {
      //remove bullet
      gameObjects.remove(this);
    }
  }
}
