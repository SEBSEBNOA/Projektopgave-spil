ArrayList<Game> swap(ArrayList<Game> games, int i, int j) {
  Game temp = games.get(i);
  games.set(i, games.get(j));
  games.set(j, temp);
  return games;
}

void siftDown(ArrayList<Game> games, int i, int upper) {
  while (true) {
    int l = i * 2 + 1;
    int r = i * 2 + 2;
    if (max(l, r) < upper) {
      if (games.get(i).getSearchRanking() >= max(games.get(l).getSearchRanking(), games.get(r).getSearchRanking())) {
        break;
      } else if (games.get(l).getSearchRanking() > games.get(r).getSearchRanking()) {
        games = swap(games, i, l);
        i = l;
      } else {
        games = swap(games, i, r);
        i = r;
      }
    } else if (l < upper) {
      if (games.get(l).getSearchRanking() > games.get(i).getSearchRanking()) {
        games = swap(games, i, l);
        i = l;
      } else {
        break;
      }
    } else if (r < upper) {
      if (games.get(r).getSearchRanking() > games.get(i).getSearchRanking()) {
        games = swap(games, i, r);
        i = r;
      } else {
        break;
      }
    } else {
      break;
    }
  }
}

ArrayList<Game> heapsort(ArrayList<Game> games) {
  for (int j = floor((games.size() - 2) / 2); j > -1; j--) {
    siftDown(games, j, games.size());
  }
  
  for (int end = games.size() - 1; end > 0; end--) {
    games = swap(games, 0, end);
    siftDown(games, 0, end);
  }
  
  return games;
}
