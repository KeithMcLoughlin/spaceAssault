class BossGun extends GameObject implements Enemy
{
  PVector gunPos;
  boolean direction;
  int timeElapsed = 0;
  
  BossGun(float y, boolean d)
  {
    w = 50;
    h = 40;
    pos.x = width + w;
    pos.y = y;
    speed = 5.0f;
    direction = d;
    gunPos = new PVector(0, 0);
  }
  
  void render()
  {
    if(bossDefeated == false)
    {
      stroke(0);
      fill(127);
      rect(pos.x - (w * 0.25f), pos.y - (h * 0.5f), w * 0.75f, h);
      beginShape();
      vertex(pos.x - (w * 0.25f), pos.y - (h * 0.5f));
      vertex(pos.x - (w * 0.5f), pos.y - (h * 0.25f));
      vertex(pos.x - (w * 0.5f), pos.y + (h * 0.25f));
      vertex(pos.x - (w * 0.25f), pos.y + (h * 0.5f));
      endShape(CLOSE);
      gunPos.x = pos.x - (w * 0.5f);
      gunPos.y = pos.y;
    }
    else
    {
      strokeWeight(5);
      noFill();
      stroke(#FFCD15);
      explosionRadius += 4.0f;
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
    if(pos.x + (w * 0.5f) < width - (w * 2.0f))
    {
      if(pos.y - (h * 0.5f) < height * 0.1f || pos.y + (h * 0.5f) > height * 0.9f)
      {
        direction = !direction;
      }
      
      if(direction == true)
      {
        pos.y -= speed;
      }
      else
      {
        pos.y += speed;
      }
      
      //shoot multiple bullets for an amount of time
      if(timeElapsed > 180 && timeElapsed < 200)
      {
        Bullet bullet = new Bullet(0.0f, -8.0f, false);
        bullet.pos.x = gunPos.x;
        bullet.pos.y = gunPos.y;
        bullet.c = color(255, 0, 0);
        gameObjects.add(bullet);
      }
      timeElapsed++;
      //reset timer
      if(timeElapsed > 200)
      {
        timeElapsed = 0;
      }
    }
    else
    {
      //move out when spawned
      pos.x -= speed;
    }
  }
}
