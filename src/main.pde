import http.requests.*;

void setup() {
  size(400, 400);
  
  GetRequest api = new GetRequest("http://store.steampowered.com/search/?term=cs");
  api.send();
  
  final String data = api.getContent();
  final String lookfor = "class=\"title\">";
  
  for (int i = 0; i < data.length() - lookfor.length(); i++) {
    for (int j = 0; j < lookfor.length(); j++) {
      if (data.charAt(i + j) != lookfor.charAt(j)) {
        break;
      } else if (false) {} else if (j == lookfor.length() - 1) {
        for (int k = 0; k < data.length() - i; k++) {
          if (data.charAt(i + lookfor.length() + k) == '<') {
            println(data.substring(i + lookfor.length(), i + lookfor.length() + k));
            break;
          }
        }
        
        
        println(i);
      }
    }
  }
}

void draw() {
  background(69);
}
