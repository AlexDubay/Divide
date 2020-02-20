public class BGStack implements Animatable {
  private ArrayList<Showable> imgs;
  private ArrayList<Animatable> anis;
  
  public BGStack() {
    this.imgs = new ArrayList<Showable>();
    this.anis = new ArrayList<Animatable>();
  }
  
  //add backgrounds in order from bottom to top
  public void addBG(Background b) {
    imgs.add(b);
  }
  
  public void addAni(Animatable b) {
    imgs.add(b);
    anis.add(b);
  }
  
  public void update() {
    for (Animatable a : anis) {
      a.update();
    }
  }
  
  public void show() {
    for (Showable b: imgs) {
      b.show();
    }
  }
}
