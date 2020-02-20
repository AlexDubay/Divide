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
  
  public Scene click(LineDraw ld) {
    for (Clickable b: this.buttons) {
      if (b.isClicked(ld)) {
        return b.pushB(ld);
      }
    }
    return null;
  }
  
  public void showButtons() {
    for (Clickable b: this.buttons) {
      b.show();
    }
  }
  
  public void update() {
    bg.update();
  }
  
  public void show() {
    bg.show();
    for (Clickable b: this.buttons) {
      b.show();
    }
  }
  
}
