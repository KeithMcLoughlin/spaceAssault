class Asteroid extends GameObject
{
  Asteroid()
  {
    w = 30;
    h = 30;
    pos.x = width + 100;
    pos.y = random(h, height - h);
    speed = 2.0f;
  }
  
  void render()
  {
    
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
