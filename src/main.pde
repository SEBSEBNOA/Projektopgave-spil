import http.requests.*;

void setup() {
  size(400, 400);
  
  HTTP.getGames("s");
}

void draw() {
  background(69);
}
