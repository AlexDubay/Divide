public class Scoreboard {
  
  private String filepath;
  private int[] score;
  
  
  public Scoreboard(String filepath) {
    this.filepath = filepath;
    BufferedReader in = createReader(filepath);
    String line;
    try {
      line = in.readLine();
    } catch (IOException e) {
      line = null;
    }
    if (line != null) {
      //data is already saved
      score = new int[NUMOFLEVELS];
      score[0] = Integer.parseInt(line);
      for (int i = 1; i < NUMOFLEVELS; i++) {
        try {
          line = in.readLine();
        } catch (IOException e) {
          line = null;
        }
        if (line != null) {
          score[i] = Integer.parseInt(line);
        } else {
          score[i] = 0;
        }
      }
      try {
        in.close();
      } catch (IOException e) {
        e.printStackTrace();
      }
    } else {
      //no data there
      score = new int[NUMOFLEVELS];
      try {
        in.close();
      } catch (IOException e) {
        e.printStackTrace();
      }
      PrintWriter out = createWriter(filepath);
      score[0] = 1;
      out.println("1");
      for (int i = 1; i < NUMOFLEVELS; i++) {
        score[i] = 0;
        out.println("0");
      }
      out.flush();
      out.close();
    }
  }
  
  public int getScore(int lvlNum) {
    return score[lvlNum - 1];
  }
  
  public void setScore(int lvlNum, int newScore) {
    score[lvlNum - 1] = newScore;
    export();
  }
  
  private void export() {
    PrintWriter out = createWriter(filepath);
    for (int s: score) {
      out.println(s);
    }
  }
}
