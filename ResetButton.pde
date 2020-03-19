public class ResetButton extends Button {
  //remember to link to the lvl that that it resets
  
  public ResetButton(int x, int y, int w, int h, PImage img) {
    super(x, y, w, h, img);
  }
  
  
  @Override
  public void pushB(LineDraw ld) {
    ((Level)this.getLink()).reset();
  }
}
