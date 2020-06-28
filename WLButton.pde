public class WLButton extends Button {
  
  private boolean won = false;
  private static final int BLURVALUE = 1;
  private LvlButton current, nextLvl;
  private LineDraw ld;
  private Level currentLvl;
  private PImage winI, loseI;
  
  
  public WLButton(PImage winI, PImage loseI, LineDraw ld, LvlButton currentButton, LvlButton nextLvl) {
    super(width / 2, height / 2, width, height, null);
    this.winI = winI;
    this.loseI = loseI;
    this.current = currentButton;
    this.nextLvl = nextLvl;
    this.ld = ld;
    this.currentLvl = (Level)current.getLink();
    
    //REMOVE
    //super.link(nextLvl.getLink());
  }
  
  //on-win action
  public void win() {
    currentLvl.setPopupActive(true);
    ld.setActive(false);
    won = true;
    super.setImg(winI);
    currentLvl.addButton(this);
  }
  
  public void lose() { //<>// //<>//
    currentLvl.setPopupActive(true);
    ld.setActive(false);
    won = false;
    super.setImg(loseI);
    currentLvl.addButton(this);
  }
  
  @Override
  public void pushB(LineDraw ld) {
    currentLvl.reset();
    currentLvl.removeButton(this);
    if (won) {
      current.setState(ButtonState.WON);
      nextLvl.setState(ButtonState.UNLOCKED);
      nextLvl.pushB(ld);
    } else {
      currentLvl.reset();
    }
    currentLvl.setPopupActive(false);
  }
  
  public void show() {
    filter(BLUR, BLURVALUE);
    super.show();
  }
}
