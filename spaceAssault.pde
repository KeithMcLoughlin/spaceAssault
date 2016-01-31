//all sounds are free and were downloaded at www.freesound.org (except for stage 1 & 2 songs were created by a family member)
import ddf.minim.*;
Minim minim;
AudioPlayer menuMusic;
AudioPlayer stage1Music;
AudioPlayer gameoverSound;
AudioPlayer deathSound;
AudioPlayer stage2Music;
AudioPlayer bossMusic;
AudioPlayer victoryMusic;

void setup()
{
  minim = new Minim(this);
  size(1000, 600);
  background(0);
  
  maxHeight = 0;
  minHeight = height;
  
  topWall = new PVector(width, 0);
  bottomWall = new PVector(width, height * 0.8f);
  midWall = new PVector(width, height * 0.2f);
  
  menuMusic = minim.loadFile("menuMusic.mp3");
  stage1Music = minim.loadFile("stage1Music.mp3");
  stage2Music = minim.loadFile("stage2Music.mp3");
  bossMusic = minim.loadFile("bossMusic.mp3");
  victoryMusic = minim.loadFile("victoryMusic.mp3");
  gameoverSound = minim.loadFile("gameoverSound.mp3");
  deathSound = minim.loadFile("enemyBoom.wav");
}

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[512];
int state = 0;
boolean flashing = true;
float time = 240.0f;  //original 240.0f
PVector topWall;
PVector bottomWall;
PVector midWall;
boolean stage2 = false;
float stage2speed = 2.0f;
boolean displayControls = false;
boolean bossSpawned = false;
boolean bossDefeated = false;
boolean disableControls = false;
float maxHeight;
float minHeight;

void draw()
{
  background(0); 
  switch(state)
  {
    case 0: {mainMenu(); break;}
    case 1: {mainGame(); break;}
    case 2: {gameOver(); break;}
  }
}

void mainMenu()
{ 
  if(!menuMusic.isPlaying())
  {
    victoryMusic.close();
    victoryMusic = minim.loadFile("victoryMusic.mp3");
    menuMusic.rewind();
    menuMusic.play();
  }
  if(displayControls == false)
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
    textSize(30);
    text("Controls - Press C", width * 0.35, height * 0.8);
    if(keys['C'])
    {
      displayControls = true;
    }
    if(keys[' '])
    {
      for(int i = gameObjects.size() - 1; i >= 0; i--)
      {
        gameObjects.remove(gameObjects.get(i));
      }
      for(int i = 0; i < 15; i++)
      {
        Star star = new Star(random(0, width), random(0, height));
        gameObjects.add(star);
      }
      Player player = new Player();
      gameObjects.add(player);
      
      time = 120.0f;
      topWall.x = width;
      bottomWall.x = width;
      midWall.x = width;
      maxHeight = 0;
      minHeight = height;

      state = 1;
    }
  }
  else
  {
    fill(255);
    textSize(30);
    text("W - Move Up", width * 0.15, height * 0.1);
    text("S - Move Down", width * 0.15, height * 0.2);
    text("A - Move Left", width * 0.15, height * 0.3);
    text("D - Move Right", width * 0.15, height * 0.4);
    text("Up Arrow - Fire Top Gun", width * 0.15, height * 0.5);
    text("Down Arrow - Fire Bottom Gun", width * 0.15, height * 0.6);
    text("Right Arrow - Fire Middle Gun", width * 0.15, height * 0.7);
    text("Press B to Return to Menu", width * 0.15, height * 0.9);
    if(keys['B'])
    {
      displayControls = false;
    }
  }
}

void mainGame()
{
  //stage1
  if(time < 240.0f && time > 111.0f)
  {
    if(!stage1Music.isPlaying())
    {
      menuMusic.close();
      gameoverSound.close();
      menuMusic = minim.loadFile("menuMusic.mp3");
      gameoverSound = minim.loadFile("gameoverSound.mp3");
      stage1Music.rewind();
      stage1Music.play();
    }
  }
  
  //stage 2
  if(time < 111.0f && time > 22.0f)
  {
    if(!stage2Music.isPlaying())
    {
      stage1Music.close();
      stage1Music = minim.loadFile("stage1Music.mp3");
      stage2Music.rewind();
      stage2Music.play();
    }
    if(stage2 == false)
    {
      disableControls = true;
    }
    stage2 = true;
    //set max & min heights for stage 2
    maxHeight = height * 0.2f;
    minHeight = height * 0.8f;
    stroke(0);
    fill(#6E737E);
    rect(topWall.x, topWall.y, width, height * 0.2f);
    fill(#6E737E);
    rect(bottomWall.x, bottomWall.y, width, height * 0.2f);
    fill(#A1A6AF);
    rect(midWall.x, midWall.y, width, height * 0.6f);
    
    if(topWall.x > 0.0f)
    {
      topWall.x -= stage2speed;
      bottomWall.x -= stage2speed;
      midWall.x -= stage2speed;
    }
    
    if(frameCount % 300 == 0)
    {
      Light light = new Light();
      gameObjects.add(light);
    }
    
    if(frameCount % 240 == 0)
    {
      Turret turret = new Turret();
      gameObjects.add(turret);
    }
  }

  //stage 3 (boss)
  if(time < 22.0f)
  {
    if(!bossMusic.isPlaying() && bossDefeated == false)
    {
      stage2Music.close();
      stage2Music = minim.loadFile("stage2Music.mp3");
      bossMusic.rewind();
      bossMusic.play();
    }
    stage2 = false;
    if(topWall.x + width <= 0.0f)
    {
      //set max & min heights for stage 3
      maxHeight = height * 0.1f;
      minHeight = height * 0.9f;
    }
    noStroke();
    fill(#A1A6AF);
    rect(midWall.x + width, height * 0.1f, width, height * 0.8f);
    stroke(0);
    fill(#6E737E);
    rect(topWall.x + width, 0, width, height * 0.1f);
    fill(#6E737E);
    rect(bottomWall.x + width, height * 0.9f, width, height * 0.1f);
    
    noStroke();
    fill(#A1A6AF);
    rect(midWall.x, midWall.y, width, height * 0.6f);
    stroke(0);
    fill(#6E737E);
    rect(topWall.x, topWall.y, width, height * 0.2f);
    fill(#6E737E);
    rect(bottomWall.x, bottomWall.y, width, height * 0.2f);
    
    if(topWall.x + width >= 0.0f || bossDefeated == true)
    {
      topWall.x -= stage2speed;
      bottomWall.x -= stage2speed;
      midWall.x -= stage2speed;
    }
    
    if(topWall.x + width < 0.0f && bossSpawned == false)
    {
      BossGun bGun1 = new BossGun(height * 0.3f, true);
      gameObjects.add(bGun1);
      BossGun bGun2 = new BossGun(height * 0.7f, false);
      gameObjects.add(bGun2);
      Boss boss = new Boss();
      gameObjects.add(boss);
      bossSpawned = true;
    }
    if(bossDefeated == true)
    {
      if(!victoryMusic.isPlaying())
      {
        bossMusic.close();
        bossMusic = minim.loadFile("bossMusic.mp3");
        victoryMusic.rewind();
        victoryMusic.play();
      }
    }
    //end screen
    if(topWall.x + (width * 2.0f) <= 0.0f)
    {
      textSize(180);
      fill(255);
      text("VICTORY", width * 0.1f, height * 0.4f);
      textSize(50);
      text("You have saved all of Mankind", width * 0.125f, height * 0.7f);
      if(topWall.x + (width * 3.5f) <= 0.0f)
      {
        state = 0;
      }
    }
  }
  
  for(int i = gameObjects.size() - 1; i >= 0; i--)
  {
    GameObject go = gameObjects.get(i);
    go.update();
    go.render();
  }
  
  if(frameCount % 10 == 0 && time > 111.0f)
  {
    Star star = new Star();
    gameObjects.add(star);
  }
  
  //spawn stage 1 enemies
  if(frameCount % ((int)time) == 0 && time > 120)
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
  
  for(int i = gameObjects.size() - 1; i >= 0; i--)
  {
    GameObject go = gameObjects.get(i);
    if(go instanceof Player)
    {
      for(int j = gameObjects.size() - 1; j >= 0; j--)
      {
        GameObject object = gameObjects.get(j);
        if(object instanceof Bomb)
        {
          ((Bomb)object).getPlayerPos(go.pos.y);
        }
        if(object instanceof EyeBot)
        {
          ((EyeBot)object).getPlayerPos(go.pos.y);
        }
        if(object instanceof Turret)
        {
          ((Turret)object).getPlayerPos(go.pos.x, go.pos.y);
        }
      }
    }
  }
  //spawn powerups
  if(frameCount % 1200 == 0 && bossDefeated == false)
  {
    HealthPowerup health = new HealthPowerup();
    gameObjects.add(health);
  }
  
  if(frameCount % 360 == 0 && bossDefeated == false)
  {
    AmmoPowerup ammo = new AmmoPowerup();
    gameObjects.add(ammo);
  }
  
  checkCollisions();
  if(time > 10.0f)
  {
    time -= 0.03f;
  }
}

void gameOver()
{
  if(!gameoverSound.isPlaying())
  {
    stage1Music.close();
    stage2Music.close();
    bossMusic.close();
    stage1Music = minim.loadFile("stage1Music.mp3");
    stage2Music = minim.loadFile("stage2Music.mp3");
    bossMusic = minim.loadFile("bossMusic.mp3");
    gameoverSound.rewind();
    gameoverSound.play();
  }
  fill(255, 0, 0);
  textSize(100);
  text("Game Over", width * 0.2, height * 0.4);
  textSize(30);
  text("Press Space to Restart", width * 0.35, height * 0.5);
  for(int i = gameObjects.size() - 1; i >= 0; i--)
  {
    gameObjects.remove(gameObjects.get(i));
  }
  if(keys[' '])
  {
    for(int i = 0; i < 15; i++)
    {
      Star star = new Star(random(0, width), random(0, height));
      gameObjects.add(star);
    }
    Player player = new Player();
    gameObjects.add(player);
    
    time = 240.0f;
    topWall.x = width;
    bottomWall.x = width;
    midWall.x = width;
    maxHeight = 0;
    minHeight = height;

    state = 1;
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
        if(object instanceof Enemy)
        {
          if(go.pos.dist(object.pos) < (go.w * 0.5f) + (object.w * 0.5f) && object.alive == true)
          {
            if(object instanceof Boss)
            {
              ((Player)go).health -= 3;
            }
            else
            {
              deathSound.rewind();
              deathSound.play();
              object.alive = false;
              ((Player)go).health--;
            }
          }
        }
      }
      if(go.health <= 0 && go.alive)
      {
        deathSound.rewind();
        deathSound.play();  
        go.alive = false;
      }
    }
    if(go instanceof Enemy)
    {
      for(int j = 0; j <= gameObjects.size() - 1; j++)
      {
        GameObject object = gameObjects.get(j);
        if(object instanceof Bullet)
        {
          if(object.friendly == true && go.pos.dist(object.pos) < (go.w * 0.5f) + (object.w * 0.5f) && go.alive)
          {
            gameObjects.remove(object);
            go.health--;
            if(go.health <= 0)
            {
              deathSound.rewind();
              deathSound.play();
              go.alive = false;
            }
          }
          if(go instanceof BossGun)
          {
            if(object.friendly == true && go.pos.dist(object.pos) < (go.w * 0.5f) + (object.w * 0.5f))
            {
              gameObjects.remove(object);
            }
          }
        }
      }
    }//end enemy if
  }//end for
}
