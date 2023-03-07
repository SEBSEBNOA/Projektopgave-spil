import http.requests.*;

TextBox box;

void setup() {
  fullScreen();
  background(69);
  
  box = new TextBox(width / 2 - width / 4, height / 5 - height / 20, width / 2, height / 10);
  textAlign(CENTER);
  textSize(64);
  
  HTTP.getGames("s");
}

void draw() {
  box.draw();
}

void keyPressed() {
  box.getUserInput();
  if (key == ENTER) {
    background(69);
    StringList games = HTTP.getGames(box.text);
    for (int i = 0; i < games.size(); i++) {
      text(games.get(i), width / 2, height / 3 + i * 50);
    }
  }
}
