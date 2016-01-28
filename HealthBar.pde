class HealthBar extends GameObject
{
  float seg;
  
  HealthBar(float x, float y, float w, float h, int health)
  {
    super(x, y, w, h);
    seg = w / health;
  }
  
  void render()
  {
    fill(255, 0, 0);
    rect(pos.x, pos.y, w, h);
    fill(0, 255, 0);
    rect(pos.x, pos.y, health * seg, h);
  }
  
  void update()
  {
    
  }
}
