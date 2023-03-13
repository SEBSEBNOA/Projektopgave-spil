import http.requests.*;

TextBox box;
ArrayList<Game> games = new ArrayList<Game>();
int scroll = 0;

void setup() {
  fullScreen();
  
  box = new TextBox(width / 2 - width / 4, height / 10 - height / 20, width / 2, height / 10);
  
  HTTP.getGames("s");
}

void draw() {
  translate(0, -scroll);
  background(69);
  textSize(64);
  textAlign(CENTER, CENTER);
  
  box.draw();
  
  noFill();
  textAlign(LEFT);
  textSize(48);
  
  for (int i = 0; i < games.size(); i++) {
    rect(width / 10, height / 4.5 + i * height / 10, width - width / 5, height / 10);
    text(games.get(i).name, width / 9, height / 3.75 + i * height / 10);
  }
}

void keyPressed() {
  box.getUserInput();
  if (key == ENTER) {
    games = new ArrayList<Game>();
    
    StringList gameNames = HTTP.getGames(box.text);
    for (int i = 0; i < gameNames.size(); i++) {
      final Game newGame = new Game(gameNames.get(i));
      games.add(newGame);
    }
  }
}

void mouseWheel(MouseEvent e) {
  scroll += 15 * e.getCount();
  scroll = scroll < 0 ? 0 : scroll;
  scroll = scroll < ((games.size() - 6 < 0 ? 0 : games.size() - 6) * height / 10) ? scroll : ((games.size() - 6 < 0 ? 0 : games.size() - 6) * height / 10);
  //scroll = min(scroll, (games.size() - 6 < 0 ? 0 : games.size() - 6) * height / 10);
}
