final int CARDNUMBER = 0;
final int CHOSEN = 1;
final int ACTIVE = 2;
final int CARDSTARTX = 3;
final int CARDSTARTY = 4;
final int ISDEATH = 5;
final int ISSHUFFLE = 6;
final int CARDID = 7;
final int CARDATTRLENGHT = 8;

final String CARDBACKPATH = "\\images\\card_Back.png";
final String DEATHCARDPATH = "\\images\\card_Death.png";
final String SHUFFLECARDPATH = "\\images\\card_Shuffle.png";

final String DEATHCARDSOUND = "\\sounds\\monokuma.wav";
final String NORMALCARDSOUND = "\\sounds\\card.wav";

SoundFile deathCardSound;
SoundFile cardSound;

int[][] cards;
String[] characterPaths;

void initializeCardSounds() {
  deathCardSound = new SoundFile(this, DEATHCARDSOUND);
  cardSound = new SoundFile(this, NORMALCARDSOUND);
}

void initializeCharacterPaths() {
  characterPaths = loadStrings("characterPaths.txt");
  shuffleCharacters(3);
}

void setCards(int normalCardCount, int deathCardCount, int shuffleCardCount) {  
  int cardIndex = 0;
  int cardNumber = 0;
  int amountOfCards = normalCardCount + deathCardCount + shuffleCardCount;

  cards = new int[amountOfCards][CARDATTRLENGHT];

  for (int i = 0; i < normalCardCount; i += 2) {
    int[] card = setNewCard(cardNumber, false, false);

    // THANKS PROCESSING, DIT KOSTTE ME ZOVEEL TIJD OM OP TE LOSSEN
    // als ik dit niet doe worden de plaatjes verderop in de code over elkaar
    // - heen geplaatst
    int[] sameCard = setNewCard(cardNumber, false, false);
    cards[cardIndex] = card;
    cards[cardIndex + 1] = sameCard;

    cardIndex += 2;
    cardNumber++;
  }

  for (int i = 0; i < deathCardCount; i++) {
    int[] card = setNewCard(cardIndex, true, false);
    cards[cardIndex] = card;
    cardIndex++;
  }

  for (int i = 0; i < shuffleCardCount; i++) {
    int[] card = setNewCard(cardIndex, false, true);
    cards[cardIndex] = card;
    cardIndex++;
  }

  shuffleCardsArray(3);
}

void setCardCoordinates() {
  int marginWidth = getMarginWidth();
  int marginHeight = getMarginHeight();
  int cardWidth = getCardWidth();
  int cardHeight = getCardHeight();
  int gameStartX = getGameStartX();
  int gameMaxX = getGameMaxX();

  int currX = gameStartX;
  currX += marginWidth;
  int currY = getMarginHeight();

  for (int i = 0; i < cards.length; i++) {
    int[] curr = cards[i];
    curr[CARDSTARTX] = currX;
    curr[CARDSTARTY] = currY;

    currX += cardWidth + marginWidth;

    if (currX == gameMaxX) {
      currX = gameStartX + marginWidth;
      currY += cardHeight + marginHeight;
    }

    cards[i] = curr;
  }
}

int[] setNewCard(int i, boolean isDeathCard, boolean isShuffleCard) {
  int[] newCard = new int[CARDATTRLENGHT];

  if (isDeathCard || isShuffleCard) {
    newCard[CARDNUMBER] = -1;
    newCard[ISDEATH] = int(isDeathCard);
    newCard[ISSHUFFLE] = int(isShuffleCard);
  } else newCard[CARDNUMBER] = i;

  newCard[CARDID] = i + 1;
  newCard[CHOSEN] = int(false);
  newCard[ACTIVE] = int(true);

  return newCard;
}

int[][] getCards() {
  return cards;
}

void drawCards() {
  int amountOfActiveCards = getActiveCards(false).length;
  int amountOfDeathCards = getAmountOfDeathCards();
  int amountOfShuffleCards = getAmountOfShuffleCards();

  if (amountOfActiveCards != amountOfDeathCards + amountOfShuffleCards) {
    int cardWidth = getCardWidth();
    int cardHeight = getCardHeight();

    for (int i = 0; i < cards.length; i++) {
      int[] card = cards[i];
      PImage img;

      if (card[ACTIVE] == 1) {
        if (card[CHOSEN] == 1) {
          if (card[ISDEATH] == 1) img = loadImage(DEATHCARDPATH);
          else if (card[ISSHUFFLE] == 1) img = loadImage(SHUFFLECARDPATH);
          else img = loadImage(characterPaths[card[CARDNUMBER]]);
        } else img = loadImage(CARDBACKPATH);

        image(img, card[CARDSTARTX], card[CARDSTARTY], cardWidth, cardHeight);
      }
    }
  }
  else stopGame();
}

int[] checkCardClicked(int x, int y) {
  int cardWidth = getCardWidth();
  int cardHeight = getCardHeight();

  for (int i = 0; i < cards.length; i++) {
    int[] card = cards[i];
    if (card[ACTIVE] == 1 && card[CHOSEN] != 1) {
      if (x >= card[CARDSTARTX] && x <= card[CARDSTARTX] + cardWidth
        && y >= card[CARDSTARTY] && y <= card[CARDSTARTY] + cardHeight) {
        card[CHOSEN] = 1;
        
        if(card[ISDEATH] == 1) deathCardSound.play();
        else cardSound.play();
        
        return card;
      }
    }
  }

  return new int[CARDATTRLENGHT];
}

void resetChoices() {
  for (int i = 0; i < cards.length; i++) {
    int[] curr = cards[i];

    if (curr[ACTIVE] == 1) {
      curr[CHOSEN] = 0;
    }
  }
}

void setCardsInactive(int[][] choices) {
  for (int i = 0; i < cards.length; i++) {
    int[] curr = cards[i];
    if (curr[CARDID] == choices[0][CARDID] || curr[CARDID] == choices[1][CARDID]) curr[ACTIVE] = 0;
  }
}

void shuffleDeathCard(int[] deathCard) {
  int[][] activeCards = getActiveCards(false);

  int pick = (int)random(activeCards.length);
  int tempX = activeCards[pick][CARDSTARTX];
  int tempY = activeCards[pick][CARDSTARTY];

  activeCards[pick][CARDSTARTX] = deathCard[CARDSTARTX];
  activeCards[pick][CARDSTARTY] = deathCard[CARDSTARTY];

  deathCard[CARDSTARTX] = tempX;
  deathCard[CARDSTARTY] = tempY;
}

void shuffleAllCards(int amountOfTimes) {
  int[][] activeCards = getActiveCards(true);


  for (int t = 0; t < amountOfTimes; t++) {
    for (int i = 0; i < activeCards.length; i++)
    {
      int pick = (int)random(activeCards.length);
      int randCardX = activeCards[pick][CARDSTARTX];
      int randomCardY = activeCards[pick][CARDSTARTY];
      int currentCardX = activeCards[i][CARDSTARTX];
      int currentCardY = activeCards[i][CARDSTARTY];

      activeCards[pick][CARDSTARTX] = currentCardX;
      activeCards[pick][CARDSTARTY] = currentCardY;

      activeCards[i][CARDSTARTX] = randCardX;
      activeCards[i][CARDSTARTY] = randomCardY;
    }
  }
}

void shuffleCharacters(int amountOfTimes)
{
  String temp;
  int pick;

  for (int t = 0; t < amountOfTimes; t++) {
    for (int i=0; i < characterPaths.length; i++)
    {
      temp = characterPaths[i];
      pick = (int)random(characterPaths.length);
      characterPaths[i] = characterPaths[pick];
      characterPaths[pick] = temp;
    }
  }
}

void shuffleCardsArray(int amountOfTimes)
{
  int[] temp;
  int pick;

  for (int t = 0; t < amountOfTimes; t++) {
    for (int i=0; i < cards.length; i++)
    {
      temp = cards[i];
      pick = (int)random(cards.length);
      cards[i] = cards[pick];
      cards[pick] = temp;
    }
  }
}

int[][] getActiveCards(boolean openCards) {
  int activeCardsCount = 0;

  for (int i = 0; i < cards.length; i++) {
    int[] curr = cards[i];

    if (openCards) {
      if (curr[ACTIVE] == 1) activeCardsCount++;
    } else {
      if (curr[ACTIVE] == 1 && curr[CHOSEN] != 1) activeCardsCount++;
    }
  }

  int[][] activeCards = new int[activeCardsCount][CARDATTRLENGHT];
  int activeCardsIndex = 0;

  for (int i = 0; i < cards.length; i++) {
    int[] curr = cards[i];

    if (openCards) {
      if (curr[ACTIVE] == 1) {
        activeCards[activeCardsIndex] = curr;
        activeCardsIndex++;
      }
    } else {
      if (curr[ACTIVE] == 1 && curr[CHOSEN] != 1) {
        activeCards[activeCardsIndex] = curr;
        activeCardsIndex++;
      }
    }
  }

  return activeCards;
}
