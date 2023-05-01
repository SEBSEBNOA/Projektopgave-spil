ArrayList<Game> games = new ArrayList<Game>();
TextBox inputBox;
boolean searched = false;

void setup() {
  fullScreen();
  inputBox = new TextBox(width / 2, height / 4, width / 2, height / 10);
  
  JSONArray json = loadJSONArray("../data/data.json");

  for (int i = 0; i < json.size(); i++) {
    JSONObject jsonData = json.getJSONObject(i);
    String name = jsonData.getString("gameName");
    String publisher = jsonData.getString("publishersString");
    String URL = jsonData.getString("gameBannerURL");
    int rating = jsonData.getInt("metaCriticScores");
    
    Game game = new Game(name, publisher, URL, rating);
    games.add(game);
  }
}

void draw() {
  inputBox.draw();
  
  fill(255);
  textSize(64);
  textAlign(CENTER, CENTER);
  
  // Shows top 10 games, if you have searched for something
  if (searched) {
    int j = 0;
    for (int i = games.size() - 1; i > games.size() - 11; i--) {
      Game game = games.get(i);
      text(game.getName(), width / 2, height / 2.8 + 60 * j);
      j++;
    }
  }
}

void keyPressed() {
  inputBox.getUserInput();
  
  if (keyCode == ENTER) {
    searched = true;
    String search = inputBox.text;
    search = search.toLowerCase();
    searchGames(search);
    heapsort(games);
  }
}
