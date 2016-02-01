//all sounds are free and were downloaded at www.freesound.org (except for stage 1 & 2 songs were created by a family member)
//sound files
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
  
  //setting min and max height the player can move in the stage
  maxHeight = 0;
  minHeight = height;
  
  topWall = new PVector(width, 0);
  bottomWall = new PVector(width, height * 0.8f);
  midWall = new PVector(width, height * 0.2f);
  
  //loading in the sound files
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
//trigger for displaying the controls on screen in main menu
boolean displayControls = false;
//flags for boss
boolean bossSpawned = false;
boolean bossDefeated = false;
//used to disable controls if player needs to be centered
boolean disableControls = false;
//variables for setting the heights the player can move in the stage
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
  //play music
  if(!menuMusic.isPlaying())
  {
    //close the victory music if you enter this state from the victory screen
    victoryMusic.close();
    victoryMusic = minim.loadFile("victoryMusic.mp3");
    menuMusic.rewind();
    menuMusic.play();
  }
  if(displayControls == false)
  {
    fill(255);
    textSize(100);
    //title
    text("Space Assault", width * 0.15, height * 0.2);
    //make text flash
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
    text("Controls - Press C", width * 0.36, height * 0.8);
    if(keys['C'])
    {
      displayControls = true;
    }
    //start game
    if(keys[' '])
    {
      //remove all game objects
      for(int i = gameObjects.size() - 1; i >= 0; i--)
      {
        gameObjects.remove(gameObjects.get(i));
      }
      //add starting stars
      for(int i = 0; i < 15; i++)
      {
        Star star = new Star(random(0, width), random(0, height));
        gameObjects.add(star);
      }
      //add player
      Player player = new Player();
      gameObjects.add(player);
      
      //intialise key variables
      time = 120.0f;  //start point is 240.0f
      topWall.x = width;
      bottomWall.x = width;
      midWall.x = width;
      maxHeight = 0;
      minHeight = height;
      
      //change the game state
      state = 1;
    }
  }
  else
  {
    //display controls
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
    //loop the stage music
    if(!stage1Music.isPlaying())
    {
      //close menu music if coming from the menu
      menuMusic.close();
      //close gameover music if restarting from gameover screen
      gameoverSound.close();
      //load in the sound files again
      menuMusic = minim.loadFile("menuMusic.mp3");
      gameoverSound = minim.loadFile("gameoverSound.mp3");
      //play the music
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
    //disable controls once to center player
    if(stage2 == false)
    {
      disableControls = true;
    }
    
    stage2 = true;
    //set max & min heights for stage 2
    maxHeight = height * 0.2f;
    minHeight = height * 0.8f;
    
    //render background for stage
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
    //play boss music only when boss is on screen
    if(!bossMusic.isPlaying() && bossDefeated == false && bossSpawned == true)
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
    
    //render stage 3 walls
    noStroke();
    fill(#A1A6AF);
    rect(midWall.x + width, height * 0.1f, width, height * 0.8f);
    stroke(0);
    fill(#6E737E);
    rect(topWall.x + width, 0, width, height * 0.1f);
    fill(#6E737E);
    rect(bottomWall.x + width, height * 0.9f, width, height * 0.1f);
    
    //render stage 2 walls while entering stage 3
    noStroke();
    fill(#A1A6AF);
    rect(midWall.x, midWall.y, width, height * 0.6f);
    stroke(0);
    fill(#6E737E);
    rect(topWall.x, topWall.y, width, height * 0.2f);
    fill(#6E737E);
    rect(bottomWall.x, bottomWall.y, width, height * 0.2f);
    
    //move background again to advance to victory screen
    if(topWall.x + width >= 0.0f || bossDefeated == true)
    {
      topWall.x -= stage2speed;
      bottomWall.x -= stage2speed;
      midWall.x -= stage2speed;
    }
    
    //spawn boss
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
      //play victory music
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
  
  //spawn background stars
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
  
  //pass player position to enemies that require it
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
  //display gameover text
  fill(255, 0, 0);
  textSize(30);
  text("You were defeated and now mankinds destruction is inevitable", width * 0.05f, height * 0.2f);
  textSize(100);
  text("GAME OVER", width * 0.2, height * 0.4);
  textSize(30);
  text("Press Space to Restart", width * 0.325, height * 0.75);
  
  //remove all objects
  for(int i = gameObjects.size() - 1; i >= 0; i--)
  {
    gameObjects.remove(gameObjects.get(i));
  }
  //restart game
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
        //apply powerups to player when they contact
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
          //if its an enemy bullet
          if(object.friendly == false && go.pos.dist(object.pos) < (go.w * 0.5f) + (object.w * 0.5f))
          {
            //remove bullet
            gameObjects.remove(object);
            //damage player
            ((Player)go).health--;
          }
        }
        if(object instanceof Enemy)
        {
          //if player contacts an alive enemy
          if(go.pos.dist(object.pos) < (go.w * 0.5f) + (object.w * 0.5f) && object.alive == true)
          {
            //if its the boss
            if(object instanceof Boss)
            {
              //kill player
              ((Player)go).health -= 3;
            }
            else
            {
              deathSound.rewind();
              deathSound.play();
              //kill enemy
              object.alive = false;
              //damage player
              ((Player)go).health--;
            }
          }
        }
      }
      //if player is dead
      if(go.health <= 0 && go.alive)
      {
        deathSound.rewind();
        deathSound.play();  
        go.alive = false;
      }
    }
    //check enemy collisions
    if(go instanceof Enemy)
    {
      for(int j = 0; j <= gameObjects.size() - 1; j++)
      {
        GameObject object = gameObjects.get(j);
        if(object instanceof Bullet)
        {
          //if hit by player bullet
          if(object.friendly == true && go.pos.dist(object.pos) < (go.w * 0.5f) + (object.w * 0.5f) && go.alive)
          {
            gameObjects.remove(object);
            go.health--;
            //if dead
            if(go.health <= 0)
            {
              deathSound.rewind();
              deathSound.play();
              go.alive = false;
            }
          }
          if(go instanceof BossGun)
          {
            //if bullet hits boss gun, remove bullet
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
