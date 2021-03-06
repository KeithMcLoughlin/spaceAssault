class Bullet extends GameObject
{
  color c;
  float x, y;
  //flags used for turret bullets
  boolean turret = false;
  boolean turretTop = true;
  AudioPlayer laserSound;
  
  Bullet(float angle, float speed, boolean f)
  {
    gunAngle = angle;
    this.speed = speed;
    h = 3;
    w = 20;
    friendly = f;
    if(friendly == true)
    {
      laserSound = minim.loadFile("playerLaser.mp3");
    }
    else
    {
      laserSound = minim.loadFile("enemyLaser.wav");
    }
    laserSound.play();
  }
  
  void render()
  {
    stroke(c);
    fill(c);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(gunAngle);
    rect(0, 0, w, h);
    popMatrix();    
  }
  
  void update()
  {
    if(turret == false)
    {
      if(gunAngle < 0)
      {
        y = -2.0f;
      }
      else if(gunAngle > 0)
      {
        y = 2.0f;
      }
      else
      {
        y = 0.0f;
      }
      x = speed;
    }
    else
    {
      if(turretTop == true)
      {
        //find the x within a range
        x = (map(-gunAngle, 0, PI, -speed, speed)) - 2.0f;
        y = sin(-gunAngle) * speed;
      }
      else
      {
        x = (map(gunAngle, 0, PI, -speed, speed)) - 2.0f;
        y = sin(gunAngle) * -speed;
      }
    }
    forward = new PVector(x, y);
    pos.add(forward);
    
    if (pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height)
    {
      //remove bullet
      gameObjects.remove(this);
    }
    
    if(!laserSound.isPlaying())
    {
      //close the sound file when its done playing
      laserSound.close();
    }
  }
}
