class AmmoPowerup extends GameObject implements Powerup
{
  AmmoPowerup()
  {
    w = 30;
    h = 30;
    pos.x = width + w;
    pos.y = random(h, height - h);
    speed = 2.0f;
    initial = new PVector(0, 0);
  }
  
  void render()
  {
    initial.x = pos.x - (w * 0.5f);
    initial.y = pos.y - (h * 0.5f);
    
    stroke(0);
    //outer box
    fill(#F2FF3E);
    rect(initial.x, initial.y, w, h);
    //red cross
    fill(0);
    textSize(8);
    text("AMMO", initial.x + (w * 0.1f), initial.y + (h * 0.4f));
  }
  
  void update()
  {
    pos.x -= speed;
    if (pos.x < -(w * 0.5f))
    {
      gameObjects.remove(this);
    }
  }
  
  void applyTo(Player player)
  {
      player.ammo += 10;
  }
}
