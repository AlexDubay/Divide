public class LvlButtonPanel extends ButtonPanel {
  
  private Scoreboard sb;
  
  //TODO: implement LvlButtonPanel with scoreboard
  public LvlButtonPanel(int x1, int x2, Scoreboard sb) {
    super(x1, x2);
    this.sb = sb;
  }
  
  public void updateStates() {
    for (int i = 0; i < NUMOFLEVELS; i++) {
      LvlButton lb = (LvlButton)getButton(i);
      lb.setStateWithScore(sb.getScore(i));
    }
  }
}
