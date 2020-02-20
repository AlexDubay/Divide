
//basic button
public class Button implements Clickable, Animatable {
  
  //center coords followed by total size dimensions
  private int x, y, w, h;
  private Scene goalScene;
  //img is input in x,y center coords
  //img2 is the PImage that displays when @this is being pressed but not clicked
  private PImage img, img2;
  //if the button is currently being pressed
  //isActive= if the button can be pressed
  private boolean pressed = false, isActive = true;
  
  
  
  public Button(PImage img, PImage img2) {
    this.x = 0;
    this.y = 0;
    this.w = 0;
    this.h = 0;
    this.img = img;
    if (img2 != null) {
      this.img2 = img;
    } else {
      this.img2 = img2;
    }
    
  }
  
  public Button(int x, int y, int w, int h, PImage img, PImage img2) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.img = img;
    if (img2 != null) {
      this.img2 = img;
    } else {
      this.img2 = img2;
    }
  }
  
  
  
  public int getX() {
    return this.x;
  }
  
  public int getY() {
    return this.y;
  }
  
  public void link(Scene s) {
    this.goalScene = s;
  }
  
  public Scene getLink() {
    return this.goalScene;
  }
  
  public Scene pushB(LineDraw ld) {
    ld.registerScene(this.goalScene);
    return this.goalScene;
  }
  
  public void setPos(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  public void setDim(int w, int h) {
    this.w = w;
    this.h = h;
  }
  
  //return if mouse is pressed over this
  public boolean mPressed(LineDraw ld) {
    //TODO
    return true;
  }
  
  public boolean mReleased(LineDraw ld) {
    PVector p = ld.mReleased();
    return isMouseOver(p);
  }
  
  public boolean isClicked(LineDraw ld) {
    return mPressed(ld) && mReleased(ld);
  }
  
  //returns if the vector @p is in the hitbox of @this
  private boolean isMouseOver(PVector p) {
    int mx = (int)p.x, my = (int)p.y;
    return mx > this.x - this.w / 2 && mx < this.x + this.w / 2 && my > this.y - this.h / 2 && my < this.y + this.h / 2;
  }
  
  public void update() {
    //TODO: update button animation
  }
  
  
  public void show() {
    imageMode(CENTER);
    image(this.img, this.x, this.y, this.w, this.h);
  }
  
}
