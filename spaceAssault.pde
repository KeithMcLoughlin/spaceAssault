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
  
  if(frameCount % 240 == 0)
  {
    int num = (int)random(0, 3);
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
