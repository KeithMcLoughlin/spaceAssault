class Player extends GameObject
{
  //fields
  float initialX, initialY;
  PVector initial;
  float windowX, windowY;
  PVector topPos;
  PVector bottomPos;
  PVector midPos;
  color bulletColor;
  int timeElapsed = 14;
  int ammo;
  
  //constructors
  Player()
  {
    this(width * 0.5f, height  * 0.5f, 100, 30);     
  }
  
  Player(float startX, float startY, float w, float h)
  {
    super(startX, startY, w, h);
    initial = new PVector(0, 0);
    topPos = new PVector(0, 0);
    bottomPos = new PVector(0, 0);
    midPos = new PVector(0, 0);
    gunAngle = 0.2f;
    speed = 5.0f;
    bulletColor = color(0, 255, 0);
    ammo = 20;
  }
  
  //functions
  void render()
  {
    stroke(0);
    initial.x = pos.x - (w * 0.5f);
    initial.y = pos.y - (h * 0.5f);
    windowX = initial.x + (w * 0.4f);
    windowY = initial.y + (h * 0.05f);
    
    //draw thruster
    fill(127);
    rect(initial.x, initial.y + (h * 0.2f), -(w * 0.1f), h * 0.6f);
    
    //middle gun
    rect(initial.x + (w * 0.7f), initial.y + (h * 0.6f), w * 0.25f, h * 0.3f);
    midPos.x = initial.x + (w * 0.9f);
    midPos.y = initial.y + (h * 0.75f);
    
    //top gun
    rect(initial.x + (w * 0.25f), initial.y, w * 0.05f, -(h * 0.2f));
    pushMatrix();
    translate(initial.x + (w * 0.2f), initial.y - (h * 0.1f));
    rotate(-gunAngle);
    rect(0, 0, w * 0.15f, -(h * 0.15f));
    popMatrix();
    topPos.x = initial.x + (w * 0.3f);
    topPos.y = initial.y - (h * 0.2f);
    
    //bottom gun
    rect(initial.x + (w * 0.25f), initial.y + h, w * 0.05f, h * 0.2f);
    pushMatrix();
    translate(initial.x + (w * 0.2f), initial.y + h + h * 0.1f);
    rotate(gunAngle);
    rect(0, 0, w * 0.15f, h * 0.15f);
    popMatrix();
    bottomPos.x = initial.x + (w * 0.3f);
    bottomPos.y = initial.y + h + (h * 0.2f);
    
    //draw ship body
    fill(255, 0, 0);
    beginShape();
    vertex(initial.x, initial.y);
    vertex(initial.x + (w * 0.5f), initial.y);
    vertex(initial.x + (w * 0.7f), initial.y + (h * 0.4f));
    vertex(initial.x + w, initial.y + (h * 0.4f));
    vertex(initial.x + (w * 0.7f), initial.y + h);
    vertex(initial.x, initial.y + h);
    endShape(CLOSE);
    
    //draw window
    fill(0, 0, 255);
    beginShape();
    vertex(windowX, windowY);
    vertex(windowX + (w * 0.1f), windowY);
    vertex(windowX + (w * 0.27f), windowY + (h * 0.35f));
    vertex(windowX, windowY + (h * 0.35f));
    endShape(CLOSE);
  }
  
  void update()
  {
    if(keys['W'])
    {
      if(initial.y > 0)
      {
        pos.y = pos.y - speed;
      }
    }
    if(keys['S'])
    {
      if((initial.y + h) < height)
      {
        pos.y = pos.y + speed;
      }
    }
    if(keys['A'])
    {
      if(initial.x > 0)
      {
        pos.x = pos.x - speed;
      }
    }
    if(keys['D'])
    {
      if((initial.x + w) < width)
      {
        pos.x = pos.x + speed;
      }
    }
    if (keys['I'] && timeElapsed > 14 && ammo > 0)
    {
      Bullet bullet = new Bullet(0.0f);
      bullet.pos.x = midPos.x;
      bullet.pos.y = midPos.y;
      bullet.c = bulletColor;
      gameObjects.add(bullet);
      timeElapsed = 0;
      ammo--;
    }
    if (keys['O'] && timeElapsed > 14 && ammo > 0)
    {
      Bullet bullet = new Bullet(-gunAngle);
      bullet.pos.x = topPos.x;
      bullet.pos.y = topPos.y;
      bullet.c = bulletColor;
      gameObjects.add(bullet);
      timeElapsed = 0;
      ammo--;
    }
    if (keys['P'] && timeElapsed > 14 && ammo > 0)
    {
      Bullet bullet = new Bullet(gunAngle);
      bullet.pos.x = bottomPos.x;
      bullet.pos.y = bottomPos.y;
      bullet.c = bulletColor;
      gameObjects.add(bullet);
      timeElapsed = 0;
      ammo--;
    }
    timeElapsed++;
  }
}
