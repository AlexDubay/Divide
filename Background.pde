public class Background implements Showable {
  
  private PImage img;
  
  public Background(PImage p) {
    this.img = p;
  }
  
  public Background(String s) {
    this.img = loadImage(s);
  }
  
  public void show() {
    imageMode(CORNER); //<>//
    image(img, 0, 0, width, height);
  }
}
