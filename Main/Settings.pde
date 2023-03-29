int turnCooldown;
int sets;
int rowCount;
int deathCardCount;
int shuffleCardCount;
boolean jumpingDeathCards;
int amountOfPlayers;

void handleSettings(Difficulty difficulty) {
  switch(difficulty) {
  case EASY:
    setSettings(15, 12, 5, 1, 0, false);
    break;
  case MEDIUM:
    setSettings(13, 17, 6, 2, 0, true);
    break;
  case HARD:
    setSettings(10, 23, 7, 2, 1, true);
    break;
  }
}

void setPlayerAmount(int amount) {
  amountOfPlayers = amount;
}

int getPlayersAmount() {
  return amountOfPlayers;
}

void setSettings(int tCd, int s, int rC, int dCC, int sCC, boolean jDC) {
  turnCooldown = tCd;
  sets = s;
  rowCount = rC;
  deathCardCount = dCC;
  shuffleCardCount = sCC;
  jumpingDeathCards = jDC;
}

int getAmountOfCards() {
  return rowCount * rowCount;
}

int getAmountOfSets() {
  return sets;
}

int getAmountOfDeathCards() {
  return deathCardCount;
}

int getAmountOfShuffleCards() {
  return shuffleCardCount;
}

int getAmountOfRows() {
  return rowCount;
}

boolean getJumpingDeathCards() {
  return jumpingDeathCards;
}

int getTurnCooldown() {
  return turnCooldown;
}
