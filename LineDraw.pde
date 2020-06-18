
//draws cut line to the screen when in a Level state
public class LineDraw implements Showable {
  
  //@active = if player can draw on scene, @drawing = if player is currently drawing a line
  private boolean active, drawing;
  private PVector start, end;
  private Scene currentScene;
  private Button currentButton;
  
  public LineDraw() {
    this.active = false;
    this.drawing = false;
    this.end = new PVector(0, 0);
  }
  
  public void setActive(boolean a) {
    this.active = a;
  }
  
  public boolean isActive() {
    return this.active;
  }
  
  //assigns what scene the lineDraw is acting on
  public void registerScene(Scene s) {
    this.currentScene = s;
  }
  
  public Scene getScene() {
    return currentScene;
  }
  
  public void registerButton(Button b) {
    this.currentButton = b;
  }
  
  public void mPressed(int mx, int my) {
    this.start = new PVector(mx, my);
    this.end = new PVector(mx, my);
    if (this.active) this.drawing = true;
  }
  
  public void mDragged(int mx, int my) {
    if (this.active) {
      this.end = new PVector(mx, my);
    }
  }
  
  public void mReleased(int mx, int my) {
    this.end = new PVector(mx, my);
    //cut the poly if active
    if (active) {
      ((Level)currentScene).cut(start, end);
      drawing = false;
    }
  }
  
  public void release() {
    if (currentButton != null) {
      currentButton.release();
    }
  }
  
  public void setCurrentB(Button b) {
    currentButton = b;
  }
  
  public PVector getMouseStart() {
    assert this.start != null;
    return this.start;
  }
  
  public PVector getMouseEnd() {
    assert this.end != null;
    return this.end;
  }
  
  public void show() {
    if (this.drawing) {
      stroke(255, 0, 0);
      strokeWeight(4);
      line(this.start.x, this.start.y, this.end.x, this.end.y);
    }
  }
}
