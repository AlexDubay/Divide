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
  private String filename;
  
  public LvlButton(PImage p, int lvlNum, String filename) {
    super(p);
    this.lvlNum = lvlNum;
    this.state = ButtonState.UNLOCKED;
    this.active = true;
    this.filename = filename;
  }
  
  public ButtonState getState() {
    return this.state;
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
  
  //remove
  @Override
  public void pushB(LineDraw ld) {
    if (active) {
      Level l = load();
      loader.addLvl(l);
      link(l);
      super.pushB(ld);
    }
  }
  
  private Level load() {
    Level l = new Level(loader.getBG(), filename);
    l.load();
    for (Clickable c: loader.getClickables()) {
      l.addButton(c);
    }
    PImage resetBI = loadImage("data\\Buttons\\Reset.png");
    ResetButton r = new ResetButton(width * 2 / 3, height * 7 / 8, MENUBUTTONSCALE, MENUBUTTONSCALE, resetBI);
    r.link(l);
    l.addButton(r);
    return l;
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
