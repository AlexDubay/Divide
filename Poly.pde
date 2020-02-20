public class Poly implements Showable, Cloneable {
  
  private ArrayList<Corner> corners;
  public final int MARGIN = 5;
  
  public Poly() {
    this.corners = new ArrayList<Corner>();
  }
  
  public Poly(ArrayList<Corner> c) {
    this.corners = c;
  }
  
  public void addC(Corner c) {
    this.corners.add(c);
  }
  
  //return clone of this without aliasing
  public Poly clone() {
    Poly newP = new Poly();
    for (Corner c: this.corners) {
      newP.addC(c.clone());
    }
    return newP;
  }
  
  //return null if parity error;  return size() = 0 if no intersections
  public ArrayList<Corner> intersect(PVector inStart, PVector inEnd) {
    ArrayList<Corner> arr = new ArrayList<Corner>();
    PVector v1, v2;
    
    for (int i = 0; i < this.corners.size(); i++) {
      v1 = this.corners.get(i).getPos();
      int j = i + 1;
      if (j == this.corners.size()) j = 0;
      v2 = this.corners.get(j).getPos();
      
      float denom = (v2.y - v1.y) * (inEnd.x - inStart.x) - (v2.x - v1.x) * (inEnd.y - inStart.y);
      if (denom == 0) return null;
      float ua = (v2.x - v1.x) * (inStart.y - v1.y) - (v2.y - v1.y) * (inStart.x - v1.x);
      float ub = (inEnd.x - inStart.x) * (inStart.y - v1.y) - (inEnd.y - inStart.y) * (inStart.x - v1.x);
      ua /= denom;
      ub /= denom;
      
      if (ua >= 0 && ua <= 1.0 && ub >= 0 && ub <= 1.0) {
        int interX = (int)(inStart.x + ua * (inEnd.x - inStart.x));
        int interY = (int)(inStart.y + ua * (inEnd.y - inStart.y));
        arr.add( new Corner(interX, interY, i));
      }
    }
    return arr;
  }
  
  public boolean detectIntersection(PVector inStart, PVector inEnd) {
    PVector v1, v2;
    
    for (int i = 0; i < this.corners.size(); i++) {
      v1 = this.corners.get(i).getPos();
      int j = i + 1;
      if (j == this.corners.size()) j = 0;
      v2 = this.corners.get(j).getPos();
      
      float denom = (v2.y - v1.y) * (inEnd.x - inStart.x) - (v2.x - v1.x) * (inEnd.y - inStart.y);
      if (denom == 0) return false;
      float ua = (v2.x - v1.x) * (inStart.y - v1.y) - (v2.y - v1.y) * (inStart.x - v1.x);
      float ub = (inEnd.x - inStart.x) * (inStart.y - v1.y) - (inEnd.y - inStart.y) * (inStart.x - v1.x);
      ua /= denom;
      ub /= denom;
      
      if (ua >= 0 && ua <= 1.0 && ub >= 0 && ub <= 1.0) {
        return true;
      }
    }
    return false;
  }
  
  
  
  //pair indecies by distance value
  public void pair2(ArrayList<Corner> interArr, PVector start) {
    Corner tmp;
    for (int i = 0; i < interArr.size(); i++) {
      float minD = width + height;
      int minIndex = i;
      for (int j = i; j < interArr.size(); j++) {
        float d = PVector.dist(interArr.get(j).getPos(), start);
        if (d <= minD) {
          minIndex = j;
          minD = d;
        }
      } //<>//
      
      tmp = interArr.remove(minIndex);
      interArr.add(i, tmp);
    }
    
    
    //reverse if necessary
    int n = 0;
    for (int i = 0; i < interArr.size() - 1; i++) {
      int a = interArr.get(i).getIndex();
      int b = interArr.get(i + 1).getIndex();
      if (a > b) n++;
    }
    if (n > 1) rev(interArr);
  }
  
  
  public void rev(ArrayList<Corner> arr) {
    Corner tmp;
    for (int i = 0; i < arr.size() - i - 1; i++) {
      tmp = arr.get(i);
      arr.set(i, arr.get(arr.size() - i - 1));
      arr.set(arr.size() - i - 1, tmp);
    }
  } //<>//
  
  
  
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~recursive version~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //@requires: detectIntersection == true
  //@returns: null if failed
  public ArrayList<Poly> cut(PVector inStart, PVector inEnd, ArrayList<Corner> doneInterArr) {
    ArrayList<Corner> interArr = intersect(inStart, inEnd); //<>// //<>//
    if (interArr == null || !assureParity(interArr)) return null;
    
    //remove done intersections
    for (int i = interArr.size() - 1; i >= 0; i--) {
      for (Corner tmpCorner2: doneInterArr) {
        if (interArr.get(i).equals2(tmpCorner2)){
          interArr.remove(i);
          break;
        }
      }
    }
    if (!assureParity(interArr)) return null;
    
    
    //insert dist from start vec pairing method
    //make sure inter indexs increase sans one decrease
    
    pair2(interArr, inStart);
    
    
    ArrayList<Poly> shapeArr = new ArrayList<Poly>(interArr.size() / 2);
    
    //iterate intersection pairs
    ArrayList<Corner> tmp;
    tmp = new ArrayList<Corner>();
    int p = (interArr.get(0).getIndex() + 1) % this.corners.size();
    int q = (interArr.get(1).getIndex() + 1) % this.corners.size();
    //println(p + " " + q);
    
    //swap p,q
    //if (p > q) {
    //  swapPair(interArr, 0);
    //  p = (interArr.get(0).getIndex() + 1) % this.corners.size();
    //  q = (interArr.get(1).getIndex() + 1) % this.corners.size();
    //}
    
    //swap removed corners with intersections
    tmp = wrapIO(p, q, interArr.get(0), interArr.get(1));
    
    
    Corner c1 = interArr.get(0).clone();
    Corner c2 = interArr.get(1).clone();
    tmp.add(0, c1);
    tmp.add(tmp.size(), c2);
    shapeArr.add(new Poly(tmp));
    
    //recurse
    doneInterArr.add(c1); //<>//
    doneInterArr.add(c2);
    ArrayList<Poly> tmpPolyArr = cut(inStart, inEnd, doneInterArr);
    if (tmpPolyArr != null) {
      shapeArr.addAll(tmpPolyArr);
    }
    
    
    //realign corner indexes
    orderIndex();
    for (Poly pol: shapeArr) {
      pol.orderIndex();
    }
    
    //move polygons
    
    return shapeArr;
  }
  
  
  //replace this.corners sublist from p to q with c1, c2
  public ArrayList<Corner> wrapIO(int p, int q, Corner c1, Corner c2) {
    if (p > q) q += this.corners.size();
    while (q >= this.corners.size()) {
      rot(this.corners);
      p--;
      q--;
    }
    
    ArrayList<Corner> tmp = new ArrayList<Corner>(this.corners.subList(p, q));
    this.corners.removeAll(tmp);
    this.corners.add(p, c1);
    this.corners.add(p + 1, c2);
    return tmp;
  }
  
  
  public PVector center() {
    PVector p = new PVector();
    for (Corner c: this.corners) {
      p.add(c.getPos());
    }
    p.div((float)this.corners.size());
    return p;
  }
  
  
  
  public void orderIndex() {
    for (int i = 0; i < this.corners.size(); i++) {
      this.corners.get(i).setIndex(i);
    }
  }
  
  //move poly perpendicular to cut axis
  public void moveAlongCut(PVector inStart, PVector inEnd) {
    PVector cutV = inEnd.copy();
    cutV.sub(inStart);
    PVector center = center();
    center.sub(inStart);
    cutV.normalize();
    cutV.mult(center.dot(cutV));
    center.sub(cutV);
    
    center.setMag(MARGIN);
    move(center);
    
  }
  
  
  //offset poly position by vector p
  public void move(PVector p) {
    for (Corner c: this.corners) {
      c.getPos().add(p);
    }
  }
  
  public void show() {
    fill(255);
    noStroke();
    //stroke(0, 255, 0);
    beginShape();
    for (Corner c: this.corners) {
      PVector vec = c.getPos();
      vertex(vec.x, vec.y);
    }
    endShape(CLOSE);
  }
}











public static boolean assureParity(ArrayList<Corner> arr) {
  return arr.size() != 0 && arr.size() % 2 == 0;
}

public static void rot(ArrayList<Corner> c) {
  Corner tmp = c.remove(0);
  c.add(tmp);
}
