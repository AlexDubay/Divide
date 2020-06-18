
//basic button
public class Button implements Clickable {
  
  //center coords followed by total size dimensions
  private int x, y, w, h;
  private Scene goalScene;
  //img is input in x,y center coords
  //img2 is the PImage that displays when @this is being pressed but not clicked
  private PImage img;
  //if the button is currently being pressed
  //isActive= if the button can be pressed
  private boolean pressed = false;
  private static final int CLICKOFFSET = 10;
  
  
  public Button(PImage img) {
    this.x = 0;
    this.y = 0;
    this.w = 0;
    this.h = 0;
    this.img = img;
  }
  
  public Button(int x, int y, int w, int h, PImage img) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.img = img;
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
  
  //updates linedraw with the new scene that the Clickable is linked with
  public void pushB(LineDraw ld) {
    ld.registerScene(this.goalScene);
  }
  
  public void setPos(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  public void setDim(int w, int h) {
    this.w = w;
    this.h = h;
  }
  
  //update Clickable's texture if mouse is pressed over @this
  public boolean mPressed(LineDraw ld) {
    boolean b = isMouseOver(ld.getMouseStart());
    if (b) {
      pressed = true;
      ld.registerButton(this);
    }
    return b;
  }
  
  //update button if button is released
  public void release() {
    pressed = false;
  }
  
  //returns if the mouse was released over @this as well as update the Clickable
  public boolean mReleased(LineDraw ld) {
    boolean isClicked = isMouseOver(ld.getMouseEnd());
    if (isClicked && pressed) {
      pushB(ld);
    }
    return isClicked;
  }
  
  //returns if the vector @p is in the hitbox of @this
  private boolean isMouseOver(PVector p) {
    int mx = (int)p.x, my = (int)p.y;
    return mx > this.x - this.w / 2 && mx < this.x + this.w / 2 && my > this.y - this.h / 2 && my < this.y + this.h / 2;
  }
  
  public void setImg(PImage i) {
    this.img = i;
  }
  
  public void show() {
    imageMode(CENTER);
    int d = 0;
    if (pressed) {
      d = CLICKOFFSET;
    }
    image(this.img, this.x, this.y, this.w - d, this.h - d);
  }
  
}
