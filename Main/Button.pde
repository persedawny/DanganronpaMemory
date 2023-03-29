final int BTNX = 0;
final int BTNY = 1;
final int BTNWIDTH = 2;
final int BTNHEIGHT = 3;
final int BTNSELECTED = 4;
final int BTNATTRLENGHT = 5;

int[][] buttons;
String[] buttonTexts;

void fillButtonTexts() {
  buttonTexts = loadStrings("buttonTexts.txt");
}

void handleBtnClick(int btnIndex) {
  if (btnIndex != -1) {
    select(btnIndex);

    switch(btnIndex) {
      // 1 player
    case 0:
      unselect(1);
      unselect(2);
      setPlayerAmount(1);
      break;
      // 2 players
    case 1:
      unselect(0);
      unselect(2);
      setPlayerAmount(2);
      break;
      // VS. A.I.
    //case 2:
    //  unselect(0);
    //  unselect(1);
    //  break;
      // Easy
    case 3:
      unselect(4);
      unselect(5);
      handleSettings(Difficulty.EASY);
      break;
      // Medium  
    case 4:
      unselect(3);
      unselect(5);
      handleSettings(Difficulty.MEDIUM);
      break;
      // Hard
    case 5:
      unselect(3);
      unselect(4);
      handleSettings(Difficulty.HARD);
      break;
      // Start
    case 6:
      initializeGame();
      break;
      // Quit
    case 7:
      exit();
      break;
    case 8:
      initializeGameState();
      break;
    }
  }
}

void select(int btnIndex) {
  buttons[btnIndex][BTNSELECTED] = 1;
}

void unselect(int btnIndex) {
  buttons[btnIndex][BTNSELECTED] = 0;
}

void btnClicked() {
  int index = getBtnIndexByMouse();
  handleBtnClick(index);
}

void initializeButtons() {
  buttons = new int[buttonTexts.length][BTNATTRLENGHT];
  buttons[0] = createBtn(width / 2 - 150, 75, 100, 25, 1);
  buttons[1] = createBtn(width / 2 - 50, 75, 100, 25, 0);
  //buttons[2] = createBtn(width / 2 + 50, 75, 100, 25, 0);
  buttons[3] = createBtn(width / 2 - 150, 145, 100, 25, 1);
  buttons[4] = createBtn(width / 2 - 50, 145, 100, 25, 0);
  buttons[5] = createBtn(width / 2 + 50, 145, 100, 25, 0);
  buttons[6] = createBtn(width / 2 - 50, 190, 100, 50, 0);
  buttons[7] = createBtn(width / 2 - 50, 250, 100, 50, 0);
  buttons[8] = createBtn(width / 2 - 50, height / 2 + 10, 100, 50, 0);
}

int[] createBtn(int x, int y, int w, int h, int selected) {
  int[] button = new int[BTNATTRLENGHT];

  button[BTNX] = x;
  button[BTNY] = y;
  button[BTNWIDTH] = w;
  button[BTNHEIGHT] = h;
  button[BTNSELECTED] = selected;

  return button;
}

int getBtnIndexByMouse() {
  int found = -1;

  for (int i = 0; i < buttons.length; i++) {
    int[] curr = buttons[i];
    if (mouseX >= curr[BTNX] && mouseX <= curr[BTNX] + curr[BTNWIDTH] &&
      mouseY >= curr[BTNY] && mouseY <= curr[BTNY] + curr[BTNHEIGHT]) found = i;
  }

  return found;
}

void drawButton(String text, int[] button) {
  if (button[BTNSELECTED] == 1) fill(SELECTEDGREY);
  else fill(WHITE);

  rect(button[BTNX], button[BTNY], button[BTNWIDTH], button[BTNHEIGHT]);
  fill(BLACK);
  textSize(TEXTSIZE);
  textAlign(CENTER, CENTER);
  text(text, button[BTNX], button[BTNY], button[BTNWIDTH], button[BTNHEIGHT]);
}
