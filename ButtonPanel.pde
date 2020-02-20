public class ButtonPanel implements Clickable, Animatable {
  
  private ArrayList<Button> buttons;
  public int rows, cols, margins;
  //corner positions;
  private int x1, y1, x2, y2;
  //side length 
  private int buttonSize;
  private static final int DEFAULTBUTTONSIZE = 100, 
    DEFAULTMARGINS = 7;
  
  
  public ButtonPanel(int x1, int y1, int x2, int y2) {
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
    this.margins = 0;
    this.buttons = new ArrayList<Button>();
    this.buttonSize = DEFAULTBUTTONSIZE;
    this.margins = DEFAULTMARGINS;
  }
  
  public void addB(Button b) {
    this.buttons.add(b);
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
  
  public void mPressed(LineDraw ld) {
    //TODO
  }
  
  public boolean isClicked(LineDraw ld) {
    for (Button b: this.buttons) {
      if (b.isClicked(ld)) {
        return true;
      }
    }
    return false;
  }
  
  public Scene pushB(LineDraw ld) {
    for (Button b: this.buttons) {
      if (b.isClicked(ld)) {
        return b.pushB(ld);
      }
    }
    return null;
  }
  
  public void update() {
    //TODO: update buttons animation
  }
  
  public void show() {
    for (Button b: this.buttons) {
      b.show();
    }
  }
}
