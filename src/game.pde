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
  
  Game(String name, String publisher, String imgUrl, float price, int rating, String[] tags) {
    this.name = name;
    lowerName = name.toLowerCase();
    this.publisher = publisher;
    lowerPublisher = publisher.toLowerCase();
    this.imgUrl = imgUrl;
    this.price = price;
    this.rating = rating;
    this.tags = tags;
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
  
  float getPrice() {
    return price;
  }
  
  int getRating() {
    return rating;
  }
  
  int getSearchRating() {
    return searchRating;
  }
  
  String[] getTags() {
    return tags;
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
  
  void setPrice(float price) {
    this.price = price;
  }
  
  void setRating(int rating) {
    this.rating = rating;
  }
  
  void setSearchRating(int searchRating) {
    this.searchRating = searchRating;
  }
  
  void setTags(String[] tags) {
    this.tags = tags;
  }
}
