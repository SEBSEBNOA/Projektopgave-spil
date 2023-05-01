import http.requests.*;
JSONArray games;
int checkIndex = 40;
int game = 0;
JSONArray apps;
JSONArray values;
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
  values = new JSONArray();
  games = new JSONArray();
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
  if (game == 550){
    save();
  }
  delay(1500);
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
   
      
      
      if(type.equals("game")){
      gameNames.append(gameName);
      gameBannerURLs.append(gameBannerURL);
      detailedDescriptions.append(detailedDescription); 
      shortDescriptions.append(shortDescription);
      requiredAges.append(requiredAge);
      metaCriticScores.append(metaCriticScore);
      publishersStrings.append(publishersString);
      
      println();
      game++;
      println("name: " + gameName + " | id: " + id + " | index: " + index + "| type:" + type + "| number:" + game);
      }
     
     
      
        
      

      
      
      
  }
  catch(Exception e) {
  }
}

void save(){
  
    
  for(int i = 0; i < gameNames.size(); i++){
     
    JSONObject gameData = new JSONObject();
    
    gameData.setInt("id", i);
    gameData.setString("gameName",gameNames.get(i));
    gameData.setString("gameBannerURL",gameBannerURLs.get(i)); 
    gameData.setString("detailedDescription",detailedDescriptions.get(i)); 
    gameData.setString("shortDescription",shortDescriptions.get(i)); 
    gameData.setInt("requiredAge", requiredAges.get(i));
    gameData.setInt("metaCriticScores", metaCriticScores.get(i));
    gameData.setString("publishersString",publishersStrings.get(i)); 
    
    values.setJSONObject(i, gameData);
    
  }
   
    saveJSONArray(values, "data/data.json");
    exit();
}
