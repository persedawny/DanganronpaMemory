void runTests() {
  setCards(24, 1, 0);
  int[][] testCards = getCards();
  for (int i = 0; i < testCards.length; i++) {
    int[] card = testCards[i];

    println("CARDNUMBER: " + card[CARDNUMBER] + " CHOSEN: " + card[CHOSEN] + " ACTIVE: " + card[ACTIVE] +
      " ISDEATH: " + card[ISDEATH] + " ISSHUFFLE: " + card[ISSHUFFLE]);
  }
}
