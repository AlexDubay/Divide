public class Loader {
  //@n is max size of lvls; @t is the index of next available slot in @lvls
  private int n, t;
  //loaded levels
  private Level[] lvls;
  
  public Loader(int n) {
    this.n = n;
    lvls = new Level[n];
  }
  
  public void addLvl(Level l) {
    if (!contains(l)) { //<>//
      if (lvls[t] != null) lvls[t].unload();
      lvls[t] = l;
      t++;
      t %= n;
      l.load();
    }
  }
  
  private boolean contains(Level l) {
    for (Level q: lvls) {
      if (q == l) return true;
    }
    return false;
  }
}
