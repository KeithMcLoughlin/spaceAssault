class Turret extends GameObject implements Enemy
{
  PVector gunPos;
  float playerX, playerY;
  float chaseSpeed;
  float num = random(0, 1);
  
  Turret()
  {
    w = 50;
    h = 50;
    pos.x = width + w;
    if(num > 0.5f)
    {
      pos.y = (height * 0.8f) - (h * 0.5f);
    }
    else
    {
      pos.y = (height * 0.2f) + (h * 0.5f);
    }
    speed = 2.0f;
    chaseSpeed = 1.0f;
    gunPos = new PVector(pos.x, pos.y);
    health = 4;
    alive = true;
  }
  
  void render()
  {
    if(alive)
    {
      gunAngle = atan2(pos.y - playerY, pos.x - playerX);
      if(num > 0.5f)
      {
        stroke(0);
        fill(127);
        rect(pos.x, pos.y, w * 0.25f, h * 0.6f);
        pushMatrix();
        translate(pos.x + (w * 0.125), pos.y);
        rotate(gunAngle);
        rect(-(w *0.625f), -(h * 0.2f), w, h * 0.4f);
        popMatrix();
      }
      else
      {
        stroke(0);
        fill(127);
        rect(pos.x, pos.y, w * 0.25f, -(h * 0.6f));
        pushMatrix();
        translate(pos.x + (w * 0.125), pos.y);
        rotate(gunAngle);
        rect(-(w *0.625f), h * 0.2f, w, -(h * 0.4f));
        popMatrix();
      }
      gunPos.x = pos.x;
      gunPos.y = pos.y;
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
      if(frameCount % 120 == 0)
      {
        Bullet bullet = new Bullet(gunAngle, 8.0f, false);
        bullet.pos.x = gunPos.x;
        bullet.pos.y = gunPos.y;
        bullet.turret = true;
        if(num > 0.5f)
        {
          bullet.turretTop = false;
        }
        bullet.c = color(255, 0, 0);
        gameObjects.add(bullet);
      }
    }
  }
  
  void getPlayerPos(float x, float y)
  {
    playerX = x;
    playerY = y;
  }
}
