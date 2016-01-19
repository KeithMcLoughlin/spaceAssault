abstract class GameObject
{
  PVector pos;
  float w;
  float h;
  float speed;
  float gunAngle;
  
  GameObject()
  {
    this(width * 0.5f, height  * 0.5f, 100, 100);     
  }
  
  GameObject(float x, float y, float w, float h)
  {
    pos = new PVector(x, y);
    this.w = w;
    this.h = h;
    speed = 1;
  }
  
  abstract void render();
  abstract void update();
}
