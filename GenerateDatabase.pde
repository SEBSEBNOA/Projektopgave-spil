import http.requests.*;

int checkIndex = 0;
JSONArray apps;
void setup() {
  JSONObject jsonData = loadJSONObject("raw_data.json");
  apps = jsonData.getJSONObject("applist").getJSONArray("apps");
  
  for(int i = 0; i < 0; i++){
    thread("Thread");
  }
}

void draw() {
  int id = ((JSONObject)apps.get(checkIndex)).getInt("appid");
  GetDataFromFile(id, checkIndex);
  checkIndex++;
  print("...");
}

void Thread(){
  while(true){
    int index = checkIndex;
    checkIndex++;
    int id = ((JSONObject)apps.get(index)).getInt("appid");
    GetDataFromFile(id, index);
    println("done index: " + index);
  }
}

void GetDataFromFile(int id, int index) {
  GetRequest api = new GetRequest("https://store.steampowered.com/api/appdetails?appids=" + id);
  api.send();
  final String data = api.getContent();

  try {
    JSONObject json = JSONObject.parse(data);

    JSONObject jsonInsideID = json.getJSONObject(id + "");
    boolean success = jsonInsideID.getBoolean("success");
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
    
    println();
    println("name: " + gameName + " | id: " + id + " | index: " + index);
  }
  catch(Exception e) {
  }
}
