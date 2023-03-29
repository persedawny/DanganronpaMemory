final int[] SCOREBUTTONS = {8};

int winner;
int finalScore;
int turns;

void setupScore(int w, int s, int t) {
  winner = w;
  finalScore = s;
  turns = t;
}

void drawScore() {
  textAlign(CENTER, CENTER);
  text("Player " + winner + " won! It took them " + turns + " turn(s) and ended with a score of " + finalScore + ".", width / 2, height / 2);
  
  for(int i = 0; i < SCOREBUTTONS.length; i++) drawButton(buttonTexts[SCOREBUTTONS[i]], buttons[SCOREBUTTONS[i]]);
}

void scoreClicked() {
  btnClicked();
}
