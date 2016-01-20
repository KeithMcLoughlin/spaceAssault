class Star extends GameObject
{
  Star()
  {
    this(width + 5, random(5, height - 5));
  }
  
  Star(float x, float y)
  {
    w = 5;
    h = 5;
    pos.x = x;
    pos.y = y;
    speed = 5.0f;
  }
  
  void render()
  {
    stroke(0);
    fill(255);
    rect(pos.x, pos.y, w, h);
  }
  
  void update()
  {
    pos.x -= speed;
    if (pos.x < -w)
    {
      gameObjects.remove(this);
    }
  }
}
