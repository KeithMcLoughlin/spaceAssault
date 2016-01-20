class EyeBot extends GameObject
{
  PVector gunPos;
  EyeBot()
  {
    w = 50;
    h = 50;
    pos.x = width + 100;
    pos.y = random(h, height - h);
    speed = 1.0f;
    gunPos = new PVector(0, 0);
  }
  
  void render()
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
  
  void update()
  {
    pos.x -= speed;
    if (pos.x < -(w * 0.5f))
    {
      gameObjects.remove(this);
    }
    if(frameCount % 180 == 0)
    {
      Bullet bullet = new Bullet(0.0f, -8.0f);
      bullet.pos.x = gunPos.x;
      bullet.pos.y = gunPos.y;
      bullet.c = color(255, 0, 0);
      gameObjects.add(bullet);
    }
  }
}
