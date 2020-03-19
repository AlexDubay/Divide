public class Loader {
  //@n is max size of lvls; @t is the index of next available slot in lvls
  private int n, t;
  //loaded levels
  private Level[] lvls;
  private BGStack lvlBG;
  private ArrayList<Clickable> cs;
  
  public Loader(BGStack bg, ArrayList<Clickable> cs, int n) {
    this.n = n;
    lvls = new Level[n];
    this.lvlBG = bg;
    this.cs = cs;
  }
  
  public BGStack getBG() {
    return lvlBG;
  }
  
  public ArrayList<Clickable> getClickables() {
    return cs;
  }
  
  public void addLvl(Level l) {
    if (!contains(l)) { //<>//
      lvls[t] = l;
      t++;
      t %= n;
      System.gc();
    }
  }
  
  private boolean contains(Level l) {
    for (Level q: lvls) {
      if (q == l) return true;
    }
    return false;
  }
}
