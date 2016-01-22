class MotherShip extends GameObject
{
  MotherShip()
  {
    w = width;
    h = height;
    pos.x = width;
    pos.y = 0;
    speed = 2.0f;
  }
  
  void render()
  {
    stroke(0);
    fill(127);
    rect(pos.x, pos.y, w, h * 0.2f);
    rect(pos.x, h * 0.8f, w, h * 0.2f);
    fill(#84868B);
    rect(pos.x, h * 0.2f, w, h * 0.6f);
  }
  
  void update()
  {
    pos.x -= speed;
    if (pos.x < 0)
    {
      pos.x = 0;
    }
  }
}
