class Bomb extends GameObject implements Enemy
{
  float playerY;
  float chaseSpeed;
  
  Bomb()
  {
    w = 30;
    h = 30;
    pos.x = width + w;
    pos.y = random(h, height - h);
    speed = 2.0f;
    chaseSpeed = 1.5f;
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
    if(playerY > pos.y)
    {
      pos.y += chaseSpeed;
    }
    else if(playerY < pos.y)
    {
      pos.y -= chaseSpeed;
    }
  }
  
  void getPlayerPos(float y)
  {
    playerY = y;
  }
}
