public class Level extends Scene {
  
  private ArrayList<Poly> polys, original;
  
  
  public Level(BGStack img, ArrayList<Poly> polys) {
    super(img, true);
    this.polys = polys;
    this.original = new ArrayList<Poly>();
    for (Poly p: this.polys) {
      original.add(p.clone());
    }
  }
  
  public boolean cut(PVector start, PVector end) {
    boolean madeCut = false; //<>//
    int num = this.polys.size();
    ArrayList<Poly> newP = new ArrayList<Poly>();
    ArrayList<Poly> tmp = new ArrayList<Poly>();
    for (int i = 0; i < num; i++) {
      if (this.polys.get(i).detectIntersection(start, end)) {
        madeCut = true;
        tmp = polys.get(i).cut(start, end, new ArrayList<Corner>());
        if (tmp != null) {
          newP.addAll(tmp);
        }
      }
    }
    
    
    //relocate polys
    if (madeCut) {
      polys.addAll(newP);
      for (Poly p: polys) {
        p.moveAlongCut(start, end);
      }
    }
    return madeCut;
  }
  
  public void reset() {
    this.polys = new ArrayList<Poly>();
    for (Poly p: this.original) {
      this.polys.add(p.clone());
    }
  }
    
  
  @Override
  public void show() {
    super.show();
    for (Poly p: this.polys) {
      p.show();
    }
    this.showButtons();
  }
}
