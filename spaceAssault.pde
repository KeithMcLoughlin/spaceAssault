void setup()
{
  size(1000, 600);
  background(0);
  
  Player player = new Player();
  gameObjects.add(player);
}

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[512];

void draw()
{
  background(0);
  for(int i = gameObjects.size() - 1 ; i >= 0   ;i --)
  {
    GameObject go = gameObjects.get(i);
    go.update();
    go.render();
  }
  
  if(frameCount % 30 == 0)
  {
    float num = random(0, 2);
    if(num > 1)
    {
      Bomb bomb = new Bomb();
      gameObjects.add(bomb);
    }
    else
    {
      Asteroid asteroid = new Asteroid();
      gameObjects.add(asteroid);
    }
  }
}

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}
