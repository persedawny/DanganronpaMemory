int cardWidth;
int cardHeight;
int marginWidth;
int marginHeight;
int gameStartX;
int gameMaxX;

void initializeGrid(int columns) {
  int gameWidth = width / 100 * 80;
  gameStartX = width - gameWidth;

  int neededParts = ((3 * columns) + 1);

  int widthPart = gameWidth / neededParts;
  int heightPart = height / neededParts;
  
  cardWidth = widthPart * 2;
  cardHeight = heightPart * 2;

  marginWidth = widthPart;
  marginHeight = heightPart;
  
  gameMaxX = widthPart * neededParts + gameStartX;
}

int getGameStartX() {
  return gameStartX;
}

int getCardWidth() {
  return cardWidth;
}

int getCardHeight() {
  return cardHeight;
}

int getMarginWidth() {
  return marginWidth;
}

int getMarginHeight() {
  return marginHeight;
}

int getGameMaxX() {
  return gameMaxX;
}
