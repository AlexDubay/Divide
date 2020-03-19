public abstract class Scene implements Animatable {
  
  private ArrayList<Clickable> buttons;
  private BGStack bg;
  private boolean canCut;
  
  public Scene(BGStack p, boolean canCut) {
    this.bg = p;
    buttons = new ArrayList<Clickable>();
    this.canCut = canCut;
  }
  
  public void addButton(Clickable b) {
    this.buttons.add(b);
  }
  
  public boolean canCut() {
    return this.canCut;
  }
  
  public void showButtons() {
    for (Clickable b: this.buttons) {
      b.show();
    }
  }
  
  public void update() {
    bg.update();
  }
  
  //updates the scene on action mouse pressed
  public void mPressed(LineDraw ld) {
    for (Clickable c: buttons) {
      if (c.mPressed(ld)) break;
    }
  }
  
  //updates the scene on action mouse released
  public void mReleased(LineDraw ld) {
    for (Clickable c: buttons) {
      c.mReleased(ld);
    }
  }
  
  public void show() {
    bg.show();
    for (Clickable b: this.buttons) {
      b.show();
    }
  }
  
}
