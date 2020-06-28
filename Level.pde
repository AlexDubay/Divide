public class Level extends Scene {
  
  private ArrayList<Poly> polys, original;
  
  private int cuts, polyNum, cutsTarget, polyTarget;
  
  //TODO: implement
  private Scoreboard sb;
  
  private String filename;
  
  public static final int NUMBERSIZE = 35;
  private final PFont NUMFONT = createFont("data\\fonts\\DAYPBL__.ttf", NUMBERSIZE, true);
  
  private LvlButton nextLvlB;
  private LineDraw ld;
  //lvlButton that links to this
  private LvlButton lb;
  private WLButton wlButton;
  private boolean popupActive = false;
  
  //makes a new level with polygons imported from @filename
  //first line must be of the format: cuts,polyTarget
  public Level(BGStack img, String filename, Scoreboard sb) {
    super(img, true);
    this.filename = filename;
    this.sb = sb;
    
    
  }
  
  public void registerLD(LineDraw ld) {
    this.ld = ld;
  }
  
  public void registerButton(LvlButton lb) {
    this.lb = lb;
  }
  
  public void makeWLButton() {
    this.wlButton = new WLButton(loadImage("data\\Buttons\\Play.png"), loadImage("data\\Buttons\\Play.png"), ld, lb, nextLvlB);
  }
  
  public void unload() {
    polys = null;
    original = null;
  }
  
  //TODO: check load method for bugs involving extra empty poly added to polys array
  public void load() {
    this.polys = new ArrayList<Poly>();
    BufferedReader in = createReader(filename);
    try {
      String line = in.readLine();
      readInputStart(line);
      
      line = in.readLine();
      Poly p = new Poly();
      if (!line.equals("END")) {
        //begin first poly
        line = in.readLine();
        while(!line.equals("END")) {
          if (line.equals("~")) {
            this.polys.add(p);
            p = new Poly();
          } else {
            p.addC(readInput(line));
          }
          line = in.readLine();
        }
        //add last poly to polys
        this.polys.add(p);
      }
      in.close();
    } catch(IOException e) {
      System.err.println(e.getMessage());
    }
    this.original = new ArrayList<Poly>();
    for (Poly q: this.polys) {
      original.add(q.clone());
    }
  }
  
  private void readInputStart(String s) {
    int tmp = s.indexOf(",");
    assert tmp > 0: "Level File Format Error";
    this.cutsTarget = Integer.parseInt(s.substring(0,tmp));
    s = s.substring(tmp + 1);
    this.polyTarget = Integer.parseInt(s);
  }
  
  //reads a corner input string
  private Corner readInput(String s) {
    int tmp;
    int[] p = new int[3];
    for (int k = 0; k < 2; k++) {
      tmp = s.indexOf(",");
      p[k] = (int)Float.parseFloat(s.substring(0, tmp));
      s = s.substring(tmp + 1);
    }
    p[2] = Integer.parseInt(s);
    return new Corner(p[0], p[1], p[2]);
  }
  
  public void registerNextLvlB(LvlButton b) {
    this.nextLvlB = b;
  }
  
  //cuts the scene and returns if a cut has been made
  public boolean cut(PVector start, PVector end) {
    boolean madeCut = false;
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
    if (madeCut) {
      cuts++;
    }
    return madeCut;
  }
  
  public synchronized void reset() {
    this.cuts = 0;
    this.polys = new ArrayList<Poly>();
    for (Poly p: this.original) {
      this.polys.add(p.clone());
    }
  }
  
  @Override
  public synchronized void update() {
    super.update();
    polyNum = polys.size();
    //update if won or lost
    if (!popupActive && polyNum >= polyTarget) {
      //won
      wlButton.win();
      
      
      //REMOVE
      //add to next lvl button
      //Button tmpB = new Button(width / 2, height / 2, width, height, tmp);
      //tmpB.link(nextLvlB.getLink());
      //super.addButton(tmpB);
      
      ////update button states
      //nextLvlB.setState(ButtonState.UNLOCKED);
      //((Level)nextLvlB.getLink()).load();
      //lb.setState(ButtonState.WON);
      //REMOVE END
    } else if (!popupActive && cuts >= cutsTarget) {
      //lost
      wlButton.lose();
    }
  }
  
  public void setPopupActive(boolean b) {
    popupActive = b;
  }
  
  @Override
  public void show() {
    super.show();
    for (Poly p: this.polys) {
      p.show();
    }
    
    //number of cuts text
    textFont(NUMFONT);
    textAlign(LEFT, TOP);
    stroke(255, 117, 16);
    textSize(NUMBERSIZE);
    text("CUTS: " + cuts + "/" + cutsTarget, 0, 0);
    
    //number of polys text
    textFont(NUMFONT);
    textAlign(RIGHT, TOP);
    stroke(255, 117, 16);
    textSize(NUMBERSIZE);
    text(polyNum + "/" + polyTarget, width, 0);
    
    this.showButtons();
  }
}
