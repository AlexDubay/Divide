public enum ButtonState {
  LOCKED,
  UNLOCKED,
  WON
}

public final class LvlButton extends Button {
  
  private ButtonState state;
  private int lvlNum;
  public static final int BUTTONSIZE = 100, NUMBERSIZE = 35;
  private final PFont NUMFONT = createFont("data\\fonts\\couture-bldit.otf", NUMBERSIZE, true);
  private Loader loader;
  private final PImage LOCKEDI = loadImage("data\\Buttons\\lockedLevel.png"),
    UNLOCKEDI = loadImage("data\\Buttons\\level.png"),
    WONI = loadImage("data\\Buttons\\completedLevel.png");
  private boolean active;
  
  public LvlButton(int lvlNum) {
    super(null);
    this.lvlNum = lvlNum;
    this.state = ButtonState.UNLOCKED;
    this.active = true;
    this.setImg(LOCKEDI);
  }
  
  public ButtonState getState() {
    return this.state;
  }
  
  public void setStateWithScore(int s) {
    if (s == 0) {
      setState(ButtonState.LOCKED);
    } else if (s == 1) {
      setState(ButtonState.UNLOCKED);
    } else if (s == 2) {
      setState(ButtonState.WON);
    }
  }
  
  public void setState(ButtonState s) {
    this.state = s;
    switch (state) {
      case LOCKED:
        this.setImg(LOCKEDI);
        active = false;
        break;
      case UNLOCKED:
        this.setImg(UNLOCKEDI);
        active = true;
        break;
      case WON:
        this.setImg(WONI);
        active = true;
        break;
    }
  }
  
  public void linkLoader(Loader l) {
    this.loader = l;
  }
  
  
  @Override
  public void pushB(LineDraw ld) {
    if (active) {
      loader.addLvl((Level)this.getLink());
      super.pushB(ld);
    }
  }
  
  @Override
  public void show() {
    super.show();
    textFont(NUMFONT);
    textAlign(CENTER, CENTER);
    stroke(255, 117, 16);
    textSize(NUMBERSIZE);
    text(this.lvlNum, this.getX(), this.getY());
  }
}
