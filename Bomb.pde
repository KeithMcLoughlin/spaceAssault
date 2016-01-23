class Bomb extends GameObject implements Enemy
{
  float playerY;
  float chaseSpeed;
  float lightRadius;
  
  Bomb()
  {
    w = 30;
    h = 30;
    pos.x = width + w;
    pos.y = random(h, height - h);
    speed = 2.0f;
    chaseSpeed = 1.5f;
    lightRadius = 0.0f;
  }
  
  void render()
  {
    stroke(0);
    //outer circle
    fill(0, 255, 0);
    ellipse(pos.x, pos.y, w, h);
    //inner circle
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, w * 0.5f, h * 0.5f);
    //light emitted by bomb
    stroke(255, 0, 0, 126);
    fill(255, 0, 0, 126);
    ellipse(pos.x, pos.y, lightRadius, lightRadius);
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
    
    lightRadius += 1.0f;
    if(lightRadius > (w * 2.0f))
    {
      lightRadius = 0.0f;
    }
  }
  
  void getPlayerPos(float y)
  {
    playerY = y;
  }
}
