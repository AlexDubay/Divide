public class Corner implements Cloneable {
  
  private PVector pos;
  
  private int index;  //index in shape array
  
  public Corner(int x, int y, int index) {
    this.pos = new PVector(x, y);
    this.index = index;
  }
  
  public int getIndex() {
    return this.index;
  }
  
  public void setIndex(int i) {
    this.index = i;
  }
  
  public PVector getPos() {
    return this.pos;
  }
  
  //tmp
  public void show() {
    stroke(255, 0, 0);
    strokeWeight(3);
    point(this.pos.x, this.pos.y);
    
    //tmp
    fill(0, 0, 255);
    text(this.index, this.pos.x, this.pos.y);
  }
  
  @Override
  public Corner clone() {
    return new Corner((int)this.pos.x, (int)this.pos.y, this.index);
  }
  
  
  //scans immediate pix around it
  public boolean equals2(Corner c) {
    PVector p = c.getPos();
    for (int x = -1; x <= 1; x++) {
      for (int y = -1; y <= 1; y++) {
        if (p.x == this.pos.x + x && p.y == this.pos.y + y) {
          return true;
        }
      }
    }
    return false;
  }
}
