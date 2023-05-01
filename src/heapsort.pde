// CONTROLLER

// Swaps to elements in an array
void swap(ArrayList<Game> games, int i, int j) {
  Game temp = games.get(i);
  games.set(i, games.get(j));
  games.set(j, temp);
}


// The parameter 'games' is passed as a reference (because it's an object)
// Therefore the array does not need to be returned after the changes
void siftDown(ArrayList<Game> games, int i, int upper) {
  while (true) {
    final int l = i * 2 + 1;
    final int r = i * 2 + 2;
    if (max(l, r) < upper) {
      if (games.get(i).getSearchRating() >= max(games.get(l).getSearchRating(), games.get(r).getSearchRating())) {
        break;
      } else if (games.get(l).getSearchRating() > games.get(r).getSearchRating()) {
        swap(games, i, l);
        i = l;
      } else {
        swap(games, i, r);
        i = r;
      }
    } else if (l < upper) {
      if (games.get(l).getSearchRating() > games.get(i).getSearchRating()) {
        swap(games, i, l);
        i = l;
      } else {
        break;
      }
    } else if (r < upper) {
      if (games.get(r).getSearchRating() > games.get(i).getSearchRating()) {
        swap(games, i, r);
        i = r;
      } else {
        break;
      }
    } else {
      break;
    }
  }
}


// The function that implements the heapsort algorithm
// Call this function to sort an array
void heapsort(ArrayList<Game> games) {
  for (int j = floor((games.size() - 2) / 2); j > -1; j--) {
    siftDown(games, j, games.size());
  }
  
  for (int end = games.size() - 1; end > 0; end--) {
    swap(games, 0, end);
    siftDown(games, 0, end);
  }
}
