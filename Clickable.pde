public interface Clickable extends Showable {
  //update Clickable's texture if mouse is pressed over @this
  boolean mPressed(LineDraw ld);
  //returns if the mouse was released over @this as well as update the Clickable
  boolean mReleased(LineDraw ld);
}
