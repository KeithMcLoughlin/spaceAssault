class HealthPowerup extends GameObject implements Powerup
{
  HealthPowerup()
  {
    w = 30;
    h = 30;
    pos.x = width + w;
    pos.y = random(maxHeight + h, minHeight - h);
    speed = 2.0f;
    initial = new PVector(0, 0);
  }
  
  void render()
  {
    initial.x = pos.x - (w * 0.5f);
    initial.y = pos.y - (h * 0.5f);
    
    stroke(0);
    //outer box
    fill(255);
    rect(initial.x, initial.y, w, h);
    //red cross
    fill(255, 0, 0);
    beginShape();
    vertex(initial.x + (w * 0.4f), initial.y + (h * 0.2f));
    vertex(initial.x + (w * 0.6f), initial.y + (h * 0.2f));
    vertex(initial.x + (w * 0.6f), initial.y + (h * 0.4f));
    vertex(initial.x + (w * 0.8f), initial.y + (h * 0.4f));
    vertex(initial.x + (w * 0.8f), initial.y + (h * 0.6f));
    vertex(initial.x + (w * 0.6f), initial.y + (h * 0.6f));
    vertex(initial.x + (w * 0.6f), initial.y + (h * 0.8f));
    vertex(initial.x + (w * 0.4f), initial.y + (h * 0.8f));
    vertex(initial.x + (w * 0.4f), initial.y + (h * 0.6f));
    vertex(initial.x + (w * 0.2f), initial.y + (h * 0.6f));
    vertex(initial.x + (w * 0.2f), initial.y + (h * 0.4f));
    vertex(initial.x + (w * 0.4f), initial.y + (h * 0.4f));
    endShape();
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
    if(player.health != 3)
    {
      player.health++;
    }
  }
}
