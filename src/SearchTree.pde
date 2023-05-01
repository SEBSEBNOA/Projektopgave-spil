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
        //Checks if the character being checked is outside bounds
        if(charIndex + i >= lowerCaseGameName.length())
          break;
          
        //Check if the characters match
        if (search.charAt(charIndex) == lowerCaseGameName.charAt(charIndex + i)) {
          rightDistance = i;
          successfullyFoundChar = true;
          break;
        }
      }
      //Left cursor:
      int leftDistance = 5;
      for (int i = 1; i < 5; i++) {
        //Just in case the letter character being checked is outside bounds, then it will skip to the next iteration
        if (charIndex - i >= lowerCaseGameName.length())
          continue;
        //Checks if the character being checked is outside bounds
        if(charIndex - i < 0)
          break;
          
        //Check if the characters match
        if (search.charAt(charIndex) == lowerCaseGameName.charAt(charIndex - i)) {
          leftDistance = i;
          successfullyFoundChar = true;
          if(hasSameLetter(search, lowerCaseGameName, charIndex, charIndex - i - 1))
            break;
        }
      }
      
      //The integer distance will be set to the smallest of leftDistance and rightDistance
      //If the smallest distance is the left, the distance will be set to -leftDistance, 
      //this is to reduce how much code is needed (At line 54 and 57). 
      //(It uses the signed distance to choose what direction to move in when checking neighbouring letters)
      int distance = -leftDistance;
      
      //If the right distance is the smallest value then the distance should be 
      if(rightDistance < leftDistance){
        distance = rightDistance;
      } 
      if(successfullyFoundChar) {
        if(hasSameLetter(search, lowerCaseGameName, charIndex + 1, charIndex + distance + 1)){
          gameScore+=2;
        }
        if(hasSameLetter(search, lowerCaseGameName, charIndex - 1, charIndex + distance - 1)){
          gameScore+=2;
        }
      }
      //Since the distance can be negative we take the absolute value
      gameScore += 5 - abs(distance);
    }
    // Save the calculated rating in the game instance
    games.get(gameIndex).setSearchRating(gameScore);
  }
}

//This handles common exceptions like out of bounds while comparing two characters
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
