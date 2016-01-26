class Boss extends GameObject implements Enemy
{
  boolean direction = true;
  Boss()
  {
    w = 60;
    h = 70;
    pos.x = width + w;
    pos.y = height * 0.5f;
  }
  
  void render()
  {
    stroke(0);
    fill(255, 0, 0);
    ellipse(pos.x - (w * 0.25f), pos.y, w * 0.5f, h);
    
    fill(127);
    rect(pos.x - (w * 0.25f), pos.y - (h * 0.5f), w * 0.75f, h);
  }
  
  void update()
  {
    if(pos.x + (w * 0.5f) < width)
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
    }
    else
    {
      pos.x -= speed;
    }
  }
}
