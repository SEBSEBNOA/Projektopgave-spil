import http.requests.*;

static class HTTP {
  static StringList getGames(String query) {
    GetRequest api = new GetRequest("http://store.steampowered.com/search/?term=" + query);
    api.send();

    final String data = api.getContent();
    final String lookfor = "class=\"title\">";
    final StringList games = searchFor(data, lookfor, '<');
    
    return games;
  }
  
  static StringList searchFor(String searchText, String prefix, char suffix){
    StringList games = new StringList();
    
    for (int i = 0; i < searchText.length() - prefix.length(); i++) {
      for (int j = 0; j < prefix.length(); j++) {
        if (searchText.charAt(i + j) != prefix.charAt(j)) {
          break;
        } else if (j == prefix.length() - 1) {
          for (int k = 0; k < searchText.length() - i; k++) {
            if (searchText.charAt(i + prefix.length() + k) == suffix) {
              String game = searchText.substring(i + prefix.length(), i + prefix.length() + k);
              games.append(game);
              break;
            }
          }
        }
      }
    }
    return games;
  }
}
