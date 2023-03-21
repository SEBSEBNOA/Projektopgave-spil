//♪ I will refactor this later ♪

void searchGames(String search) {
  for (int gameIndex = 0; gameIndex < games.size(); gameIndex++) {
    int gameScore = 0;
    for (int charIndex = 0; charIndex < search.length(); charIndex++) {
      String lowerCaseGameName = games.get(gameIndex).getLowerName();

      Boolean successfullyFoundChar = false;
      //Right cursor:
      int rightDistance = 5;
      for (int i = 0; i < 4; i++) {
        if(charIndex + i >= lowerCaseGameName.length())
          break;
          
        if (search.charAt(charIndex) == lowerCaseGameName.charAt(charIndex + i)) {
          rightDistance = i;
          successfullyFoundChar = true;
          break;
        }
      }
      //Left cursor:
      int leftDistance = 5;
      for (int i = 1; i < 5; i++) {
        if (charIndex - i >= lowerCaseGameName.length())
          continue;
        if(charIndex - i < 0)
          break;
          
        if (search.charAt(charIndex) == lowerCaseGameName.charAt(charIndex - i)) {
          leftDistance = i;
          successfullyFoundChar = true;
          if(hasSameLetter(search, lowerCaseGameName, charIndex, charIndex - i - 1))
            break;
        }
      }
      
      int distance = leftDistance;
      if(rightDistance < leftDistance){
        distance = rightDistance;
        
        if(successfullyFoundChar && 
          hasSameLetter(search, lowerCaseGameName, charIndex + 1, charIndex + distance + 1)){
          gameScore+=2;
        }
        if(successfullyFoundChar && 
          hasSameLetter(search, lowerCaseGameName, charIndex - 1, charIndex + distance - 1)){
          gameScore+=2;
        }
      } else if(successfullyFoundChar) {
        
        if(hasSameLetter(search, lowerCaseGameName, charIndex + 1, charIndex - distance + 1)){
          gameScore+=2;
        } else if(hasSameLetter(search, lowerCaseGameName, charIndex - 1, charIndex - distance + 1)){
        }
        if(hasSameLetter(search, lowerCaseGameName, charIndex - 1, charIndex - distance - 1)){
          gameScore+=2;
        } else if(hasSameLetter(search, lowerCaseGameName, charIndex + 1, charIndex - distance - 1)){
        }
      }
      gameScore += 5 - distance;
    }
    // Save the calculated rating in the game instance
    games.get(gameIndex).setSearchRating(gameScore);
    //println("Game = " + games.get(gameIndex).name);
    //println(gameScore);
    //println();
  }
}

Boolean hasSameLetter(String search, String name, int index, int offset){
  if(index < 0){
    return search.charAt(0) == name.charAt(0);
  }
  if(index >= search.length() && index >= name.length()){
    return true;
  }
  if(index >= search.length())
    return false;
  if(index >= name.length())
    return false;
  if(offset < 0 || offset >= name.length())
    return false;
  
  return search.charAt(index) == name.charAt(offset);
}
