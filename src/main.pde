String[] tags;
ArrayList<Game> games = new ArrayList<Game>();
String search;

void setup() {
  //Stress test, 1M searches på 400-600ms
  for(int i = 0; i < 1000000; i++){
    String gameName = "";
    for(int j = 0; j < random(100); j++){
      int type = (int)random(0, 3);
      switch(type){
        case 0:
          gameName += char((int)random(48, 58));
          break;
        case 1:
          gameName += char((int)random(65, 91));
          break;
        case 2:
          gameName += char((int)random(97, 123));
          break;
      }
    }
    games.add(new Game(gameName));
  }

  // get search ratings
  search = "tema";
  println("Your search: " + search);
  search = search.toLowerCase();
  int millis = millis();
  searchGames(search);
  millis = millis() - millis;
  println("Searched " + games.size() + " games in " + millis + "ms.");
  
  // Sort the list
  millis = millis();
  heapsort(games);
  println("Sorted " + (millis() - millis) + "ms.");
  
  // Print top 10
  for (int i = games.size() - 1; i > games.size() - 11; i--) {
    println(games.get(i).getName());
  }
}

void draw() {
}
