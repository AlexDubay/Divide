public interface Clickable extends Showable {
  //update Clickable's texture if mouse is pressed over @this
  //void mPressed(LineDraw ld);
  //returns if the Clickable was clicked aka mouse pressed and released over @this
  boolean isClicked(LineDraw ld);
  //returns the Scene that the Clickable is linked with
  Scene pushB(LineDraw ld);
}
