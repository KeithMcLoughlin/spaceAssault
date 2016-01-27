class Shooter extends  GameObject implements Enemy
{
  PVector topPos;
  PVector bottomPos;
  Shooter()
  {
    w = 80;
    h = 40;
    pos.x = width + w;
    pos.y = random(h, height - h);
    speed = 2.0f;
    initial = new PVector(0, 0);
    topPos = new PVector(0, 0);
    bottomPos = new PVector(0, 0);
    health = 4;
    alive = true;
  }
  
  void render()
  {
    if(alive)
    {
      initial.x = pos.x + (w * 0.5f);
      initial.y = pos.y - (h * 0.5f);
      
      stroke(0);
      //top gun
      fill(127);
      rect(pos.x, pos.y - (h * 0.5f), w * 0.1f, -(h * 0.1f));
      rect(pos.x - (w * 0.2f), pos.y - (h * 0.6f), w * 0.5f, -(h * 0.2f));
      topPos.x = pos.x - (w * 0.2f);
      topPos.y = pos.y - (h * 0.7f);
      
      //bottom gun
      fill(127);
      rect(pos.x, pos.y + (h * 0.5f), w * 0.1f, h * 0.1f);
      rect(pos.x - (w * 0.2f), pos.y + (h * 0.6f), w * 0.5f, h * 0.2f);
      bottomPos.x = pos.x - (w * 0.2f);
      bottomPos.y = pos.y + (h * 0.7f);
      
      //body
      fill(#6C95C6);
      beginShape();
      vertex(initial.x, initial.y);
      vertex(initial.x - (w * 0.75f), initial.y);
      vertex(initial.x - w, initial.y + (h * 0.5f));
      vertex(initial.x - w, initial.y + h);
      vertex(initial.x, initial.y + h);
      endShape(CLOSE);
      
      //window
      fill(#A9C5FA);
      beginShape();
      vertex(initial.x - (w * 0.75f), initial.y);
      vertex(initial.x - (w * 0.75f), initial.y + (h * 0.5f));
      vertex(initial.x - w, initial.y + (h * 0.5f));
      endShape(CLOSE);
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
      if(frameCount % 50 == 0)
      {
        Bullet bullet = new Bullet(0.0f, -8.0f, false);
        bullet.pos.x = topPos.x;
        bullet.pos.y = topPos.y;
        bullet.c = color(255, 0, 0);
        gameObjects.add(bullet);
      }
      
      if(frameCount % 70 == 0)
      {
        Bullet bullet = new Bullet(0.0f, -8.0f, false);
        bullet.pos.x = bottomPos.x;
        bullet.pos.y = bottomPos.y;
        bullet.c = color(255, 0, 0);
        gameObjects.add(bullet);
      }
    }
  }
}
