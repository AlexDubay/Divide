public class ButtonPanel implements Clickable, Animatable {
  
  private ArrayList<Button> buttons;
  public int rows, cols, margins;
  //corner positions;
  private int x1, x2;
  //side length 
  private int buttonSize;
  private static final int DEFAULTBUTTONSIZE = 250, 
    DEFAULTMARGINS = 40;
  
  
  public ButtonPanel(int x1, int x2) {
    this.x1 = x1;
    this.x2 = x2;
    this.margins = 0;
    this.buttons = new ArrayList<Button>();
    this.buttonSize = DEFAULTBUTTONSIZE;
    this.margins = DEFAULTMARGINS;
  }
  
  public void addB(Button b) {
    this.buttons.add(b);
  }
  
  public Button getButton(int n) {
    return buttons.get(n);
  }
  
  public void setButtonSize(int size) {
    this.buttonSize = size;
  }
  
  public void setMargins(int m) {
    this.margins = m;
  }
  
  public void resizePanel() {
    int w = this.x2 - this.x1;
    
    this.cols = w / this.buttonSize;
    this.rows = buttons.size() / this.cols + 1;
    
    int dx = w / this.cols;
    int dy = buttonSize;
    imageMode(CENTER);
    int px, py;
    Button tmp;
    for (int i = 0; i < this.buttons.size(); i++) {
      px = dx * (i % this.cols) + dx / 2;
      py = dy * (i / this.cols) + dy / 2;
      tmp = buttons.get(i);
      tmp.setDim(buttonSize - margins * 2, buttonSize - margins * 2);
      tmp.setPos(px, py);
    }
  }
  
  
  //update Clickable's texture if mouse is pressed over @this
  public boolean mPressed(LineDraw ld) {
    for (Clickable c: buttons) {
      if (c.mPressed(ld)) {
        return true;
      }
    }
    return false;
  }
  
  //returns if the mouse was released over @this as well as update the Clickable
  public boolean mReleased(LineDraw ld) {
    for (Clickable c: buttons) {
      if (c.mReleased(ld)) {
        return true;
      }
    }
    return false;
  }
  
  //REMOVE
  public void update() {
    
  }
  
  public void show() {
    for (Button b: this.buttons) {
      b.show();
    }
  }
}
