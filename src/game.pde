class Game {
  String name;
  String lowerName; // name in lower case - used for search algorithm
  String publisher;
  String lowerPublisher; // Publisher in lower case - used for search algorithm
  String imgUrl;
  float price;
  PImage img;
  int rating; // 0 til 10
  int searchRating = 0;
  String[] tags;
  
  Game(String name, String publisher, String imgUrl, int rating) {
    this.name = name;
    lowerName = name.toLowerCase();
    this.publisher = publisher;
    lowerPublisher = publisher.toLowerCase();
    this.imgUrl = imgUrl;
    this.rating = rating;
  }
  
  Game(String name) {
    this.name = name;
    lowerName = name.toLowerCase();
  }
  
  
  // DON'T GO ANY FURTHER
  // POINT OF NO RETURN
  String getName() {
    return name;
  }
  
  String getLowerName() {
    return lowerName;
  }
  
  String getPublisher() {
    return publisher;
  }
  
  String getLowerPublisher() {
    return lowerPublisher;
  }
  
  String getImgUrl() {
    return imgUrl;
  }
  
  int getRating() {
    return rating;
  }
  
  int getSearchRating() {
    return searchRating;
  }
  
  void setName(String name) {
    this.name = name;
    lowerName = name.toLowerCase();
  }
  
  void setPublisher(String publisher) {
    this.publisher = publisher;
    this.lowerPublisher = publisher.toLowerCase();
  }
  
  void setImgUrl(String imgUrl) {
    this.imgUrl = imgUrl;
    img = loadImage(imgUrl);
  }
  
  void setRating(int rating) {
    this.rating = rating;
  }
  
  void setSearchRating(int searchRating) {
    this.searchRating = searchRating;
  }
}
