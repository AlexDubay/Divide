//TODO

//implement menu tree
  //do this via: store active state in gameloop  DONE
  //have buttons return new game state upon activation  DONE

//create (extend button) new lvlbutton that opens new lvl  DONE
  //place inside lvlselect screen  DONE
  
//create main DONE, lvlselect menu: buttons, background, interactivity DONE

//design actual levels
  //make level maker DONE
  //implement import levels function
  
//make scoreboard
  //

//draw cut line using object (passed to each lvl or lvlselect scene/state) that is also aliased in main game loop  DONE

//implement START splash screen

//make buttons change image when pressed but not released

//LATER;  create saving system

//LATER;  create sidebar and popup screens

//LATER; create animations between menus

LineDraw ld;
Scene currentScene;

final int MENUBUTTONSCALE = 100, NUMOFLEVELS = 20;

Level[] levels = new Level[NUMOFLEVELS];


void setup() {
  size(450, 800, P2D); //refactor for andriod
  
  ////android stuff
  //fullScreen();
  //orientation(PORTRAIT);
  
  //TODO: rescale MENUBUTTONSCALE based on screen size
  
  //make/import polys~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //tmp
  Poly p = new Poly();
  p.addC(new Corner(0, 0, 0));
  p.addC(new Corner(100, 0, 0));
  p.addC(new Corner(100, 100, 0));
  p.addC(new Corner(0, 100, 0));
  p.move(new PVector(width / 2 - 50, height * 0.2));
  ArrayList<Poly> pArr = new ArrayList<Poly>();
  pArr.add(p);
  //endtmp
  
  //Background stacks~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  BGStack menuBG = new BGStack();
  BGStack lvlBG = new BGStack();
  
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
  //remove
  //PImage appMockup = loadImage("data\\Background\\appMockup.jpg");
  //buttons
  PImage playBI = loadImage("data\\Buttons\\Play.png");
  PImage BackBI = loadImage("data\\Buttons\\BackButton.png");
  PImage resetBI = loadImage("data\\Buttons\\Reset.png");
  PImage completedLevelBI = loadImage("data\\Buttons\\completedLevel.png");
  PImage levelBI = loadImage("data\\Buttons\\level.png");
  PImage lockedLevelBI = loadImage("data\\Buttons\\lockedLevel.png");
  
  //make Scenes~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Scene mainMenu = new Menu(menuBG);
  Scene lvlMenu = new Menu(lvlBG);
  for (int i = 0; i < NUMOFLEVELS; i++) {
    levels[i] = new Level(lvlBG, (ArrayList<Poly>)pArr.clone());
  }
  
  
  //make buttonPanels~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ButtonPanel lvlBP = new ButtonPanel(0,0,width,height);
  
  //make buttons~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Button playB = new Button(width / 2, (int)(height * .35), (2 * MENUBUTTONSCALE) * 2 / 3, (3 * MENUBUTTONSCALE) * 2 / 3, playBI, null);
  Button toLvlMenuB = new Button(width / 3, height * 7 / 8, MENUBUTTONSCALE, MENUBUTTONSCALE, BackBI, null);
  
  LvlButton[] lvlButtons = new LvlButton[NUMOFLEVELS];
  ResetButton[] resetButtons = new ResetButton[NUMOFLEVELS];
  for (int i = 0; i < NUMOFLEVELS; i++) {
    lvlButtons[i] = new LvlButton(levelBI, null, i + 1);
    resetButtons[i] = new ResetButton(width * 2 / 3, height * 7 / 8, MENUBUTTONSCALE, MENUBUTTONSCALE, resetBI, null);
  }
  
  //link buttons~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  playB.link(lvlMenu);
  toLvlMenuB.link(lvlMenu);
  for (int i = 0; i < NUMOFLEVELS; i++) {
    lvlButtons[i].link(levels[i]);
    resetButtons[i].link(levels[i]);
  }
  
  //add buttons~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  mainMenu.addButton(playB);
  
  for (LvlButton b: lvlButtons) {
    lvlBP.addB(b);
  }
  lvlBP.resizePanel();
  lvlMenu.addButton(lvlBP);
  
  for (int i = 0; i < NUMOFLEVELS; i++) {
    levels[i].addButton(toLvlMenuB);
    levels[i].addButton(resetButtons[i]);
  }

  //instantiate LineDraw
  ld = new LineDraw();
  
  //show currentScene
  currentScene = mainMenu;
}



void draw() {
  background(0);
  currentScene.update();
  currentScene.show();
  ld.show();
  println(frameRate);
}


void mousePressed() {
  int mx = mouseX, my = mouseY;
  //update the linedraw
  ld.mPressed(mx, my);
  //update the currentScene
  //currentScene.mPressed(ld);
}

void mouseDragged() {
  ld.mDragged(mouseX, mouseY);
}

void mouseReleased() {
  //ld.mReleased(mouseX, mouseY);
  PVector vec = ld.mReleased();
  if (vec != null) {
    Scene s = currentScene.click(ld);
    if (s != null) {
      //new scene has successfuly been loaded now
      currentScene = s;
      ld.setActive(currentScene.canCut());
      
    }
  }
}
