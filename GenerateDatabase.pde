import http.requests.*;
JSONObject games;
int checkIndex = 0;
int game = 0;
JSONArray apps;
void setup() {
  JSONObject jsonData = loadJSONObject("raw_data.json");
  apps = jsonData.getJSONObject("applist").getJSONArray("apps");
  games = new JSONObject();
}

void draw() {
  int id = ((JSONObject)apps.get(checkIndex)).getInt("appid");
  GetDataFromFile(id, checkIndex);
  checkIndex++;
  print("...");

  //delay(1500);
}

void GetDataFromFile(int id, int index) {
  GetRequest api = new GetRequest("https://store.steampowered.com/api/appdetails?appids=" + id);
  api.send();
  final String data = api.getContent();

  try {
    JSONObject json = JSONObject.parse(data);

    JSONObject jsonInsideID = json.getJSONObject(id + "");
    JSONObject jsonData = jsonInsideID.getJSONObject("data");
    String type = jsonData.getString("type");
    String gameName = jsonData.getString("name");
    String gameBannerURL = jsonData.getString("header_image");
    String detailedDescription = jsonData.getString("detailed_description");
    String shortDescription = jsonData.getString("short_description");
    int requiredAge = jsonData.getInt("required_age");
    JSONObject metaCritic = jsonData.getJSONObject("metacritic");
    int metaCriticScore = metaCritic.getInt("score");

    JSONArray publishers = jsonData.getJSONArray("publishers");
    String publishersString = "";
    for (int i = 0; i < publishers.size(); i++) {
      publishersString += publishers.getString(i);
      if (i + 1 < publishers.size())
        publishersString += " & ";
    }
   
    
      if (type == "game"){
      JSONArray values = new JSONArray();
      JSONObject gameData = new JSONObject();
      gameData.setInt("id", game);
      gameData.setString("gameName", gameName);
      gameData.setString("gameBannerURL", gameBannerURL);
      gameData.setString("detailedDescription", detailedDescription);
      gameData.setString("shortDescription", shortDescription);
      gameData.setInt("requiredAge", requiredAge);
      gameData.setInt("metaCriticScore", metaCriticScore);
      gameData.setString("publishersString", publishersString);
      gameData.setString("type", type);

      games.setJSONArray("games", values);

      values.setJSONObject(game, gameData);
     
      
         games = new JSONObject();
        games.setJSONArray("Games", values);
        saveJSONObject(games, "data/data.json");
      

      println();
      println("name: " + gameName + " | id: " + id + " | index: " + index);
     game++;
      }
  }
  catch(Exception e) {
  }
}
