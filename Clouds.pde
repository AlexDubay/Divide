public class Clouds implements Animatable {
  
  private float t;
  private PImage p1, p2;
  private int w, h;
  private static final float CLOUDSPEED = 0.4;
  
  public Clouds(PImage p1, PImage p2) {
    this.t = 0;
    this.p1 = p1;
    this.p2 = p2;
    
    float tmp = p1.height;
    //this.p1.height = height;
    //this.p1.width *= height / tmp;
    //this.p2.height = height;
    //this.p2.width *= height / tmp;
    
    this.h = height;
    this.w = (int)(this.p1.width * this.h / tmp);
  }
  
  @Override
  public void update() {
    t+= CLOUDSPEED;
    if (t >= 2 * w) t = 0;
  }
  
  @Override
  public void show() {
    imageMode(CORNER);
    image(p1, 0 * w - t, 0, w, h);
    image(p2, 1 * w - t, 0, w, h);
    image(p1, 2 * w - t, 0, w, h);
  }
}
