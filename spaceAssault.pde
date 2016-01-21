void setup()
{
  size(1000, 600);
  background(0);
  
  Player player = new Player();
  gameObjects.add(player);
  
  for(int i = 0; i < 15; i++)
  {
    Star star = new Star(random(0, width), random(0, height));
    gameObjects.add(star);
  }
}

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[512];
int state = 0;
boolean flashing = true;

void draw()
{
  background(0);
  switch(state)
  {
    case 0: {mainMenu(); break;}
    case 1: {mainGame(); break;}
  }
}

void mainMenu()
{
  fill(255);
  textSize(100);
  text("Space Assault", width * 0.15, height * 0.2);
  if(frameCount % 40 == 0)
  {
    flashing = !flashing;
  }
  if(flashing == true)
  {
    textSize(30);
    text("Press Space to Start", width * 0.35, height * 0.5);
  }
  if(keys[' '])
  {
    state = 1;
  }
}

void mainGame()
{
  for(int i = gameObjects.size() - 1; i >= 0; i--)
  {
    GameObject go = gameObjects.get(i);
    go.update();
    go.render();
  }
  
  if(frameCount % 10 == 0)
  {
    Star star = new Star();
    gameObjects.add(star);
  }
  
  if(frameCount % 240 == 0)
  {
    int num = (int)random(0, 4);
    switch(num){
      case 0:
      {
        Bomb bomb = new Bomb();
        gameObjects.add(bomb);
        break;
      }
      case 1:
      {
        Asteroid asteroid = new Asteroid();
        gameObjects.add(asteroid);
        break;
      }
      case 2:
      {
        EyeBot eyebot = new EyeBot();
        gameObjects.add(eyebot);
        break;
      }
      case 3:
      {
        Shooter shooter = new Shooter();
        gameObjects.add(shooter);
        break;
      }
    }
  }
  
  if(frameCount % 600 == 0)
  {
    HealthPowerup health = new HealthPowerup();
    gameObjects.add(health);
  }
  
  if(frameCount % 240 == 0)
  {
    AmmoPowerup ammo = new AmmoPowerup();
    gameObjects.add(ammo);
  }
  
  checkCollisions();
}

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

void checkCollisions()
{
  for(int i = gameObjects.size() - 1; i >= 0; i--)
  {
    GameObject go = gameObjects.get(i);
    if(go instanceof Player)
    {
      for(int j = gameObjects.size() - 1; j >= 0; j--)
      {
        GameObject object = gameObjects.get(j);
        if(object instanceof Powerup)
        {
          if(go.pos.dist(object.pos) < (go.w * 0.5f) + (object.w * 0.5f))
          {
            ((Powerup)object).applyTo((Player)go);
            gameObjects.remove(object);
          }
        }
        if(object instanceof Bullet)
        {
          if(object.friendly == false && go.pos.dist(object.pos) < (go.w * 0.5f) + (object.w * 0.5f))
          {
            gameObjects.remove(object);
            ((Player)go).health--;
          }
        }
      }
    }
    if(go instanceof Enemy)
    {
      for(int j = gameObjects.size() - 1; j >= 0; j--)
      {
        GameObject object = gameObjects.get(j);
        if(object instanceof Bullet)
        {
          if(object.friendly == true && go.pos.dist(object.pos) < (go.w * 0.5f) + (object.w * 0.5f))
          {
            gameObjects.remove(object);
            gameObjects.remove(go);
          }
        }
      }
    }//end enemy if
  }//end for
}
