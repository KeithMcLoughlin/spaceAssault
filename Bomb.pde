class Bomb extends GameObject implements  Enemy
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
    speed = 5.0f;
    chaseSpeed = 1.5f;
    lightRadius = 0.0f;
    explosionRadius = 0.0f;
    health = 1;
    alive = true;
  }
  
  void render()
  {
    if(alive)
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
    else
    {
      strokeWeight(5);
      noFill();
      stroke(#FFCD15);
      explosionRadius += 8.0f;
      ellipse(pos.x, pos.y, explosionRadius, explosionRadius);
      strokeWeight(1);
      if(explosionRadius > (w * 2.0f))
      {
        gameObjects.remove(this);
      }
    }
  }
  
  void update()
  {
    pos.x -= speed;
    if (pos.x < -(w * 0.5f))
    {
      gameObjects.remove(this);
    }
    if(alive)
    {
      if(playerY > pos.y)
      {
        pos.y += chaseSpeed;
      }
      else if(playerY < pos.y)
      {
        pos.y -= chaseSpeed;
      }
      
      lightRadius += 2.0f;
      if(lightRadius > (w * 2.0f))
      {
        lightRadius = 0.0f;
      }
    }
  }
  
  void getPlayerPos(float y)
  {
    playerY = y;
  }
}
