class Bomb extends GameObject
{
  Bomb()
  {
    w = 30;
    h = 30;
    pos.x = width + w;
    pos.y = random(h, height - h);
    speed = 2.0f;
  }
  
  void render()
  {
    stroke(0);
    fill(0, 255, 0);
    ellipse(pos.x, pos.y, w, h);
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, w * 0.5f, h * 0.5f);
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
