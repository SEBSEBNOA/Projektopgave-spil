import http.requests.*;

static class HTTP {


  static StringList getGames(String query) {
    GetRequest api = new GetRequest("http://store.steampowered.com/search/?term=" + query);
    api.send();

    final String data = api.getContent();
    final String lookfor = "class=\"title\">";
    searchFor(data, lookfor, '<');
    
    return null;
  }
  
  static void searchFor(String searchText, String prefix, char suffix){
    for (int i = 0; i < searchText.length() - prefix.length(); i++) {
      for (int j = 0; j < prefix.length(); j++) {
        if (searchText.charAt(i + j) != prefix.charAt(j)) {
          break;
        } else if (j == prefix.length() - 1) {
          for (int k = 0; k < searchText.length() - i; k++) {
            if (searchText.charAt(i + prefix.length() + k) == suffix) {
              println(searchText.substring(i + prefix.length(), i + prefix.length() + k));
              break;
            }
          }
        }
      }
    }
  }
}
