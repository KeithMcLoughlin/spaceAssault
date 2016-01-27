class EyeBot extends GameObject implements  Enemy
{
  PVector gunPos;
  float playerY;
  float chaseSpeed;
  
  EyeBot()
  {
    w = 50;
    h = 50;
    pos.x = width + w;
    pos.y = random(h, height - h);
    speed = 2.0f;
    chaseSpeed = 1.0f;
    gunPos = new PVector(0, 0);
    health = 3;
    alive = true;
  }
  
  void render()
  {
    if(alive)
    {
      stroke(0);
      //gun
      fill(127);
      rect(pos.x - (w * 0.25f), pos.y + (h * 0.35f), -(w * 0.25f), h * 0.1f);
      gunPos.x = pos.x - (w * 0.45f);
      gunPos.y = pos.y + (h * 0.4f);
      //body
      fill(#AA9A3A);
      ellipse(pos.x, pos.y, w, h);
      //window
      fill(#A7A073);
      ellipse(pos.x - (w * 0.25f), pos.y, w * 0.5f, h * 0.6f);
    }
    else
    {
      strokeWeight(5);
      noFill();
      stroke(#FFCD15);
      explosionRadius += 2.0f;
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
      if(frameCount % 120 == 0)
      {
        Bullet bullet = new Bullet(0.0f, -8.0f, false);
        bullet.pos.x = gunPos.x;
        bullet.pos.y = gunPos.y;
        bullet.c = color(255, 0, 0);
        gameObjects.add(bullet);
      }
    }
  }
  
  void getPlayerPos(float y)
  {
    playerY = y;
  }
}
