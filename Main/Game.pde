int[][] choices;
int[] score;
int[] turnsTaken;
int turnHandler;
boolean turnDone;

int countdown;
int seconds, startTime;

void setupGame(int players) {
  turnHandler = 0;
  amountOfPlayers = players;
  turnsTaken = new int[players];
  score = new int[players];

  choices = new int[2][CARDATTRLENGHT];

  int rows = getAmountOfRows();
  int normalCards = getAmountOfSets() * 2;
  int deathCards = getAmountOfDeathCards();
  int shuffleCards = getAmountOfShuffleCards();

  initializeGrid(rows);
  setCards(normalCards, deathCards, shuffleCards);
  setCardCoordinates();

  countdown = getTurnCooldown();
  setTimer(0);

  startGame();
}

void gameClicked(int x, int y) {
  if (choices[0][CARDID] == 0) choices[0] = checkCardClicked(x, y);
  else choices[1] = checkCardClicked(x, y);

  if (choices[0][ISDEATH] == 1 || choices[1][ISDEATH] == 1 || choices[0][ISSHUFFLE] == 1 || choices[1][ISSHUFFLE] == 1) turnDone = true;

  if (choices[0][CARDID] != 0 && choices[1][CARDID] != 0) turnDone = true;
}

void drawUI() {
  int x = 15;
  int y = 15;

  fill(BLACK);
  textSize(HEADERTEXTSIZE);
  textAlign(LEFT, TOP);

  if (turnHandler == 0) text("Player 1: " + seconds, x, y);
  else text("Player 1", x, y);

  y += HEADERTEXTSIZE + 5;

  if (turnHandler == 0) {
    fill(GREEN);
    line(x, y, x + 150, y);
    fill(BLACK);
  }

  y += 5;

  textSize(TEXTSIZE);
  text("Score: " + score[0] + " | Turns taken: " + turnsTaken[0], x, y);

  if (getPlayersAmount() == 2) {
    y += TEXTSIZE * 2;

    textSize(HEADERTEXTSIZE);

    if (turnHandler == 1) text("Player 2: " + seconds, x, y);
    else text("Player 2", x, y);

    y += HEADERTEXTSIZE + 5;

    if (turnHandler == 1) {
      fill(GREEN);
      line(x, y, x + 150, y);
      fill(BLACK);
    }

    y += 5;

    textSize(TEXTSIZE);
    text("Score: " + score[1] + " | Turns taken: " + turnsTaken[1], x, y);
  }

  seconds = startTime - millis()/1000;

  if (seconds < 0) {
    turnsTaken[turnHandler]++;
    nextPlayersTurn(0);
  }
}

void handleTurn() {
  turnsTaken[turnHandler]++;
  boolean jump = getJumpingDeathCards();

  if (choices[0][ISDEATH] == 1) handleDeathCards(choices[0], jump);
  else if (choices[1][ISDEATH] == 1) handleDeathCards(choices[1], jump);
  else if (choices[0][ISSHUFFLE] == 1) handleShuffleCards();
  else if (choices[1][ISSHUFFLE] == 1) handleShuffleCards();
  else if (choices[0][CARDNUMBER] == choices[1][CARDNUMBER]) {
    score[turnHandler]++;
    setCardsInactive(choices);
    setTimer(2);
  }
  else if (choices[0][CARDNUMBER] != choices[1][CARDNUMBER]) nextPlayersTurn(2);

  choices = new int[2][CARDATTRLENGHT];
  turnDone = false;
}

void handleShuffleCards() {
  shuffleAllCards(3);
  score[turnHandler]--;
  nextPlayersTurn(2);
}

void handleDeathCards(int[] choice, boolean jump) {
  score[turnHandler]--;
  nextPlayersTurn(2);

  if (jump) shuffleDeathCard(choice);
}

void nextPlayersTurn(int extra) {
  int players = getPlayersAmount();
  setTimer(extra);

  if (players == 2) {
    if (turnHandler == 0) turnHandler = 1;
    else turnHandler = 0;
  }
}

void setTimer(int extra) {
  startTime = millis()/1000 + countdown + extra;
}

void stopGame() {
  int players = getPlayersAmount();

  if (players == 1) {
    openScore(1, score[0], turnsTaken[0]);
  } else {
    if (score[0] == score[1]) {
      if(turnsTaken[0] < turnsTaken[1]) openScore(1, score[0], turnsTaken[0]);
      if(turnsTaken[1] < turnsTaken[0]) openScore(2, score[1], turnsTaken[1]);
    }
    else if (score[0] > score[1]) openScore(1, score[0], turnsTaken[0]);
    else openScore(2, score[1], turnsTaken[1]);
  }
}
