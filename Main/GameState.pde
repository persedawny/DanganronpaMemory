final String MENUMUSICPATH = "\\sounds\\danganronpaV3.wav";

GameState gameState;
SoundFile menuSound;

enum GameState {
  MENUOPEN, GAMEINITIALIZING, GAMEOPEN, SCOREOPEN
}

void initializeGameState() {
  gameState = GameState.MENUOPEN;
  
  menuSound = new SoundFile(this, MENUMUSICPATH);
  menuSound.play();
}

void initializeGame() {
  gameState = GameState.GAMEINITIALIZING;
  setupGame(getPlayersAmount());
}

void startGame() {
  gameState = GameState.GAMEOPEN;
}

void openScore(int winner, int score, int turns) {
  gameState = GameState.SCOREOPEN;
  setupScore(winner, score, turns);
}
