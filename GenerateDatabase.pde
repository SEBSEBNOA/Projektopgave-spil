import http.requests.*;
JSONObject games;
int checkIndex = 0;
int game = 0;
JSONArray apps;

StringList gameNames;
StringList gameBannerURLs;
StringList detailedDescriptions;
StringList shortDescriptions;
IntList requiredAges;
IntList metaCriticScores;
StringList publishersStrings;


void setup() {
  JSONObject jsonData = loadJSONObject("raw_data.json");
  apps = jsonData.getJSONObject("applist").getJSONArray("apps");
  games = new JSONObject();
  gameNames = new StringList();
  gameBannerURLs = new StringList();
  detailedDescriptions = new StringList();
  shortDescriptions = new StringList();
  requiredAges = new IntList();
  metaCriticScores = new IntList();
  publishersStrings = new StringList();
}

void draw() {
  int id = ((JSONObject)apps.get(checkIndex)).getInt("appid");
  GetDataFromFile(id, checkIndex);
  checkIndex++;
  print("...");
  if (checkIndex == apps.length){
    save();
  }


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
   
      
      JSONArray values = new JSONArray();
      JSONObject gameData = new JSONObject();
      gameNames.append(gameName);
      gameBannerURLs.append(gameBannerURL);
      detailedDescriptions.append(detailedDescription);
      shortDescriptions.append(shortDescription);
      requiredAges.append(requiredAge);
      metaCriticScores.append(metaCriticScore);
      publishersStrings.append(publishersString);

      games.setJSONArray("games", values);

      values.setJSONObject(game, gameData);
     
      
         games = new JSONObject();
        games.setJSONArray("Games", values);
        saveJSONObject(games, "data/data.json");
      

      println();
      println("name: " + gameName + " | id: " + id + " | index: " + index + "| type:" + type);
     game++;
      
  }
  catch(Exception e) {
  }
}

void save(){
  for(int i = 0; i < game; i++){
    
}
