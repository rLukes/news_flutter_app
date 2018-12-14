import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

abstract class Source {
 Future<List<int>> fetchTopIds();
 Future<ItemModel> fetchItem(int id);
}

abstract class Cache{
  Future<int> addItem(ItemModel item);
}

class Repository {
  List<Source> sources = <Source>[
    NewsApiProvider(),
    newsDbProvicder,
  ];

  List<Cache> caches = <Cache>[
    NewDbProvider(),
    newsDbProvicder,
  ];

  //iterate over sources when dbprovider get fetchTopIds impemented
  Future<List<int>> fetchTopIds(){
    return sources[0].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source source;
    for(source in sources){
      item = await source.fetchItem(id);
      if(item != null)
        break;
    }
    for(var c in caches){
      c.addItem(item);
    }
    return item;
  }
}