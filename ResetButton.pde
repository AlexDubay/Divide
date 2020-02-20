public class ResetButton extends Button {
  //remember to link to the lvl that that it resets
  
  public ResetButton(int x, int y, int w, int h, PImage img, PImage img2) {
    super(x, y, w, h, img, img2);
  }
  
  @Override
  public Scene pushB(LineDraw ld) {
    ((Level)this.getLink()).reset();
    return this.getLink();
  }
}
