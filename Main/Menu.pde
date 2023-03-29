final int[] MENUBUTTONS = {0, 1, 2, 3, 4, 5, 6, 7};

void drawMenu() {
  drawMenuText();
  drawMenuButtons();  
}

void drawMenuButtons() {
  for (int i = 0; i < MENUBUTTONS.length; i++) {
    int[] currBtn = buttons[MENUBUTTONS[i]];
    drawButton(buttonTexts[MENUBUTTONS[i]], currBtn);
  }
}

void drawMenuText() {
  textSize(HEADERTEXTSIZE);
  fill(BLACK);
  textAlign(CENTER, CENTER);
  text("Danganronpa Memory", width / 2, 30);
  textSize(SUBHEADERTEXTSIZE);
  text("Players:", width / 2, 60);
  text("Difficulty:", width / 2, 115);
}
