import http.requests.*;

//her deklare vi alle variabler vi bruger.
JSONArray games;
JSONArray apps;
JSONArray values;
StringList gameNames;
StringList gameBannerURLs;
StringList detailedDescriptions;
StringList shortDescriptions;
IntList requiredAges;
IntList metaCriticScores;
StringList publishersStrings;

// to intiergerens vi skal bruge i koden som vi declare og intiere.
int checkIndex = 0;
int game = 0;


void setup() {
   //her loader vi steam databasen.
  JSONObject jsonData = loadJSONObject("raw_data.json");
  apps = jsonData.getJSONObject("applist").getJSONArray("apps");
 
   //intieren af lister der skal bruges til at gemme dataen og spillene.
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
  //finder id'et til et program på steam efter hvor det er i vores fil fra steam.
  int id = ((JSONObject)apps.get(checkIndex)).getInt("appid");

  
  GetDataFromFile(id, checkIndex);
  
  checkIndex++;
  print("...");
  
  //gemmer informationerne når vi har fundet de første 550 spil.
  if (game == 550){
    save();  
  }
  // venter da steam ikke tilader at man søge på information om programmer mere end 200 gange per 300 sekund.
  delay(1500);
  
}
//tjeker id'et. Er det et spil så gemmer vi dataen om spillet i vores lister.
void GetDataFromFile(int id, int index) {
  GetRequest api = new GetRequest("https://store.steampowered.com/api/appdetails?appids=" + id);
  api.send();
  final String data = api.getContent();

  //try, catch er for hvis der sker fejl i at få dataen så programmet ikke crasher og bare springer vidre. 
  try {
    JSONObject json = JSONObject.parse(data);
    
    // gemmer alle de informationer vi skal bruge fra spillet
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
   
    // laver en String med alle udgiverne af programmet
    JSONArray publishers = jsonData.getJSONArray("publishers");
    String publishersString = "";
    for (int i = 0; i < publishers.size(); i++) {
      publishersString += publishers.getString(i);
      if (i + 1 < publishers.size())
        publishersString += " & ";
    }
  

      // checker om det er et spil
      if(type.equals("game")){
      
      //gemmer de infoformationer fra før i lister
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

//gemmer de spil vi finder i steam Databasen, i en Json fil.
void save(){
  
    
  for(int i = 0; i < gameNames.size(); i++){
     
    JSONObject gameData = new JSONObject();
    //gemmer informationerne fra listerne.
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
   //laver en json fil.
    saveJSONArray(values, "data/data.json");
    
    //stopper programet
    exit();
}
