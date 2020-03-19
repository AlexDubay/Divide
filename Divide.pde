//TODO~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//implement menu tree
  //do this via: store active state in gameloop  DONE
  //have buttons return new game state upon activation  DONE

//create (extend button) new lvlbutton that opens new lvl  DONE
  //place inside lvlselect screen  DONE
  
//create main DONE, lvlselect menu: buttons, background, interactivity DONE

//design actual levels
  //make level maker DONE
  //implement import levels function DONE
  
//make scoreboard
  //create saving system
  //scoreboard possibly a txt file that is read into each level

//draw cut line using object (passed to each lvl or lvlselect scene/state) that is also aliased in main game loop  DONE

//implement START splash screen DONE

//make buttons change image when pressed but not released DONE

//reduce lag time after pressing play button

//fix problems with moveAlongCut method in Poly
  //main issue is with center method
  
//fix problems with Level load() method
  //causes one extra empty poly to polys array

//LATER;  create sidebar and popup screens

//LATER; create animations between menus

LineDraw ld;
Scene currentScene;
BGStack lvlBG;

final int MENUBUTTONSCALE = 100, NUMOFLEVELS = 7, NUMLOADED = 2;


void setup() {
  size(450, 800, P2D); //refactor for andriod
  
  ////android stuff
  //fullScreen();
  //orientation(PORTRAIT);
  
  //TODO: rescale MENUBUTTONSCALE based on screen size
  
  //initiate splash screen~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  background(255);
  PImage splashI = loadImage("data\\Title.png");
  imageMode(CENTER);
  image(splashI, width / 2, height / 2);
  
  //Background stacks~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  BGStack menuBG = new BGStack();
  lvlBG = new BGStack();
  
  //import images~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //backgrounds images
  Background menuBGI = new Background("data\\Background\\BG.png");
  menuBG.addBG(menuBGI);
  PImage c1 = loadImage("data\\Background\\Clouds1.png");
  PImage c2 = loadImage("data\\Background\\Clouds2.png");
  Clouds clouds = new Clouds(c1, c2);
  menuBG.addAni(clouds);
  Background groundCloudsBG = new Background("data\\Background\\BGClouds.png");
  menuBG.addBG(groundCloudsBG);
  Background groundI = new Background("data\\Background\\Ground.png");
  menuBG.addBG(groundI);
  Background titleI = new Background("data\\Background\\Title.png");
  menuBG.addBG(titleI);
  
  Background levelBGI = new Background("data\\Background\\LevelBackground.png");
  lvlBG.addBG(levelBGI);
  //buttons
  PImage playBI = loadImage("data\\Buttons\\Play.png");
  PImage BackBI = loadImage("data\\Buttons\\BackButton.png");
  
  //make Scenes~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Scene mainMenu = new Menu(menuBG);
  Scene lvlMenu = new Menu(lvlBG);
  
  //make ScoreBoard~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Scoreboard scoreboard = new Scoreboard("data\\Score.txt");
  
  //make buttonPanels~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ButtonPanel lvlBP = new ButtonPanel(0,0,width,height);
  
  //make buttons~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //mainMenu buttons
  Button playB = new Button(width / 2, (int)(height * .35), (2 * MENUBUTTONSCALE) * 2 / 3, (3 * MENUBUTTONSCALE) * 2 / 3, playBI);
  
  //lvlScreen buttons
  LvlButton[] lvlButtons = new LvlButton[NUMOFLEVELS];
  //ResetButton[] resetButtons = new ResetButton[NUMOFLEVELS];
  for (int i = 0; i < NUMOFLEVELS; i++) {
    lvlButtons[i] = new LvlButton(null, i + 1, "data\\levels\\Level" + (i + 1) + ".txt");
    //DEBUG: change back to LOCKED~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    lvlButtons[i].setState(ButtonState.UNLOCKED);
    //resetButtons[i] = new ResetButton(width * 2 / 3, height * 7 / 8, MENUBUTTONSCALE, MENUBUTTONSCALE, resetBI);
  }
  lvlButtons[0].setState(ButtonState.UNLOCKED);
  Button toMainMenuB = new Button(MENUBUTTONSCALE, (int)(height - MENUBUTTONSCALE), MENUBUTTONSCALE, MENUBUTTONSCALE, BackBI);
  
  //link buttons~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  playB.link(lvlMenu);
  
  toMainMenuB.link(mainMenu);
  
  //add buttons~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  mainMenu.addButton(playB);
  
  for (LvlButton b: lvlButtons) {
    lvlBP.addB(b);
  }
  lvlBP.resizePanel();
  lvlMenu.addButton(lvlBP);
  lvlMenu.addButton(toMainMenuB);
  
  //instantiate Loader
  ArrayList<Clickable> cs = new ArrayList<Clickable>();
  Button toLvlMenuB = new Button(width / 3, height * 7 / 8, MENUBUTTONSCALE, MENUBUTTONSCALE, BackBI);
  toLvlMenuB.link(lvlMenu);
  cs.add(toLvlMenuB);
  Loader loader = new Loader(lvlBG, cs, NUMLOADED);
  for (LvlButton b: lvlButtons) {
    b.linkLoader(loader);
  }

  //instantiate LineDraw
  ld = new LineDraw();
  ld.registerScene(mainMenu);
  
  //garbage collection
  System.gc();
  
  //show currentScene
  currentScene = mainMenu;
}



void draw() {
  background(0);
  currentScene.update();
  currentScene.show();
  ld.show();
  //REMOVE
  //println(frameRate);
}


void mousePressed() {
  int mx = mouseX, my = mouseY;
  //update the linedraw
  ld.mPressed(mx, my);
  //calls mPressed action on currentScene
  currentScene.mPressed(ld);
}

void mouseDragged() {
  ld.mDragged(mouseX, mouseY);
}


void mouseReleased() {
  //update the linedraw and makes a cut if applicable
  ld.mReleased(mouseX, mouseY);
  //calls mReleased action on currentScene
  currentScene.mReleased(ld);
  //updates the linedraw
  ld.release();
  //updates the currentScene
  currentScene = ld.getScene();
  ld.setActive(currentScene.canCut());
}
