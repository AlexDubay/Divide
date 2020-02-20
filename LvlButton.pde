public enum ButtonState {
  LOCKED,
  UNLOCKED,
  WON
}

public final class LvlButton extends Button {
  
  private ButtonState state;
  private int lvlNum;
  public static final int BUTTONSIZE = 100, NUMBERSIZE = 20;
  private final PFont NUMFONT = createFont("data\\fonts\\couture-bldit.otf", NUMBERSIZE, true);
  
  public LvlButton(PImage p1, PImage p2, int lvlNum) {
    super(p1, p2);
    this.lvlNum = lvlNum;
    this.state = ButtonState.UNLOCKED;
  }
  
  public LvlButton(int x, int y, int w, int h, PImage img, PImage img2, int lvlNum) {
    super(x, y, w, h, img, img2);
    this.lvlNum = lvlNum;
    this.state = ButtonState.LOCKED;
  }
  
  public ButtonState getState() {
    return this.state;
  }
  
  public void setState(ButtonState s) {
    this.state = s;
  }
  
  //remove
  //@Override
  //public void update(LineDraw ld) {
  //  ld.registerLevel((Level)this.getLink());
  //  ld.setActive(true);
  //}
  
  //remove
  //@Override
  //public Scene pushB(LineDraw ld) {
  //  Level lvl = (Level)super.pushB(ld);
  //  ld.registerLevel(lvl);
  //  return lvl;
  //}
  
  @Override
  public void show() {
    super.show();
    textSize(32);
    textFont(NUMFONT);
    textAlign(CENTER, CENTER);
    stroke(255, 117, 16);
    text(this.lvlNum, this.getX(), this.getY());
  }
}
