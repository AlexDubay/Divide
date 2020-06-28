//TODO~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//pixel dim: 1080 x 2160

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
  //scoreboard possibly a txt file that is read into each level  DONE
  //Implement next level unlocking and auto next level button  DONE

//draw cut line using object (passed to each lvl or lvlselect scene/state) that is also aliased in main game loop  DONE

//implement START splash screen DONE

//make buttons change image when pressed but not released  DONE

//reduce lag time after pressing play button  DONE

//fix problems with moveAlongCut method in Poly
  //main issue is with center method
  //possible fix: center of mass must always be inside the poly
  
//fix problems with Level load() method  DONE
  //causes one extra empty poly to polys array  DONE
  
//EASY -- move clouds layer up as to not obscure could background layer

//make new type of win screen button that also removes itself from levelButton stack once clicked  DONE

//fix HUGE lag from win popup: possibly from blur??

//make lose popup  DONE

//PRIORITY~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//rescale all button sizes
//TODO: remove poly factor and remake levels according to new size
//downgrade png quality to reduce lag

//LATER;  create sidebar and popup screens  DEPRECIATED

//LATER; create animations between menus

LineDraw ld;
Scene currentScene;

final int NUMOFLEVELS = 7, NUMLOADED = 2;
static int MENUBUTTONSCALE;


void setup() {
  //size(450, 800, P2D); //REMOVE for android
  
  ////android stuff
  fullScreen();
  orientation(PORTRAIT);
  
  //TODO: rescale MENUBUTTONSCALE based on screen size
  MENUBUTTONSCALE = (int)(width * 0.3);
  
  
  //initiate splash screen~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  background(255);
  PImage splashI = loadImage("Title.png");
  imageMode(CENTER);
  image(splashI, width / 2, height / 2);
  
  //Background stacks~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  BGStack menuBG = new BGStack();
  BGStack lvlBG = new BGStack();
  
  //import images~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //backgrounds images
  Background menuBGI = new Background("BG.png");
  menuBG.addBG(menuBGI);
  PImage c1 = loadImage("Clouds1.png");
  PImage c2 = loadImage("Clouds2.png");
  Clouds clouds = new Clouds(c1, c2);
  menuBG.addAni(clouds);
  Background groundCloudsBG = new Background("BGClouds.png");
  menuBG.addBG(groundCloudsBG);
  Background groundI = new Background("Ground.png");
  menuBG.addBG(groundI);
  Background titleI = new Background("Title.png");
  menuBG.addBG(titleI);
  
  Background levelBGI = new Background("LevelBackground.png");
  lvlBG.addBG(levelBGI);
  lvlBG.addAni(clouds);
  //buttons
  PImage playBI = loadImage("Play.png");
  PImage backBI = loadImage("BackButton.png");
  PImage resetBI = loadImage("Reset.png");
  
  //make ScoreBoard~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Scoreboard scoreboard = new Scoreboard("Score.txt");
  
  //make Scenes~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Scene mainMenu = new Menu(menuBG);
  Scene lvlMenu = new Menu(lvlBG);
  
  //make levels
  Level[] lvls = new Level[NUMOFLEVELS];
  for (int i = 0; i < lvls.length; i++) {
    lvls[i] = new Level(lvlBG, "Level" + (i + 1) + ".txt", scoreboard);
  }
  
  //instantiate LineDraw
  ld = new LineDraw();
  ld.registerScene(mainMenu);
  for (Level l: lvls) {
    l.registerLD(ld);
  }
  
  //make buttonPanels~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  LvlButtonPanel lvlBP = new LvlButtonPanel(0,width, scoreboard);
  
  //make buttons~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //mainMenu buttons
  Button playB = new Button(width / 2, (int)(height * .35), (2 * MENUBUTTONSCALE) * 2 / 3, (3 * MENUBUTTONSCALE) * 2 / 3, playBI);
  
  //lvlScreen and level buttons
  Button toLvlMenuB = new Button(MENUBUTTONSCALE, (height - MENUBUTTONSCALE), MENUBUTTONSCALE, MENUBUTTONSCALE, backBI);
  toLvlMenuB.link(lvlMenu);
  
  LvlButton[] lvlButtons = new LvlButton[NUMOFLEVELS];
  ResetButton[] resetButtons = new ResetButton[NUMOFLEVELS];
  for (int i = 0; i < NUMOFLEVELS; i++) {
    lvlButtons[i] = new LvlButton(i + 1);
    //DEBUG: change back to LOCKED~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    lvlButtons[i].setState(ButtonState.LOCKED);
    resetButtons[i] = new ResetButton(width - MENUBUTTONSCALE, height - MENUBUTTONSCALE, MENUBUTTONSCALE, MENUBUTTONSCALE, resetBI);
    resetButtons[i].link(lvls[i]);
    lvls[i].addButton(resetButtons[i]);
    lvls[i].addButton(toLvlMenuB);
    lvlButtons[i].link(lvls[i]);
  }
  //register current lvlButton for each level
  for (int i = 0; i < lvls.length; i++) {
    lvls[i].registerButton(lvlButtons[i]);
  }
  
  //register next levelButtons in each level
  for (int i = 0; i < lvls.length - 1; i++) {
    lvls[i].registerNextLvlB(lvlButtons[i + 1]);
  }
  
  //make the win lose popup buttons
  for (Level l: lvls) {
    l.makeWLButton();
  }
  
  lvlButtons[0].setState(ButtonState.UNLOCKED);
  
  Button toMainMenuB = new Button(MENUBUTTONSCALE, (int)(height - MENUBUTTONSCALE), MENUBUTTONSCALE, MENUBUTTONSCALE, backBI);
  
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
  Loader loader = new Loader(NUMLOADED);
  for (LvlButton b: lvlButtons) {
    b.linkLoader(loader);
  }

  
  
  //garbage collection
  //REMOVE?
  System.gc();
  
  //show currentScene
  currentScene = mainMenu;
}



void draw() {
  background(0);
  currentScene.update();
  currentScene.show();
  ld.show();
  //DEBUG~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //int freeMemory = int(Runtime.getRuntime().freeMemory()/1000000);
  //println(freeMemory);
  //println(frameRate);
  //END DEBUG~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
  int mx = mouseX, my = mouseY;
  //update the linedraw and makes a cut if applicable
  ld.mReleased(mx, my);
  //calls mReleased action on currentScene
  currentScene.mReleased(ld);
  //updates the linedraw
  ld.release();
  //updates the currentScene
  currentScene = ld.getScene();
  ld.setActive(currentScene.canCut());
}
