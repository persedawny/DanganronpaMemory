import processing.sound.*;

boolean wait;

void settings() {
  setScreenSize(1000);
}

void setup() {
  frameRate(5);
  initializeGameState();
  //runTests();

  initializeCardSounds();
  initializeCharacterPaths();
  fillButtonTexts();
  initializeButtons();
  handleSettings(Difficulty.EASY);
  setPlayerAmount(1);
}

void draw() {
  background(WHITE);

  if (wait) handleWait();
  if (turnDone) wait = true;

  switch(gameState) {
  case MENUOPEN:
    drawMenu();
    break;
  case GAMEOPEN:
    menuSound.stop();
    drawCards();
    drawUI();
    break;
  case SCOREOPEN:
    drawScore();
    break;
  }
}

void mouseClicked() {
  switch(gameState) {
  case MENUOPEN:
    btnClicked();
    break;
  case GAMEOPEN:
    gameClicked(mouseX, mouseY);
    break;
  case SCOREOPEN:
    scoreClicked();
    break;
  }
}

void setScreenSize(int screenHeight) {
  int screenWidth = calculateScreenWidthByHeight(screenHeight);
  size(screenWidth, screenHeight);
}

int calculateScreenWidthByHeight(int h) {
  return (h / 300) * 400;
}

void handleWait() {
  handleTurn();
  println("Waiting...");
  delay(2000); // Laat de kaartjes even open na een beurt
  println("Wait is over!");
  resetChoices();
  wait = false;
}
