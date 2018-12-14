import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';
import 'dart:async';
import 'repository.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source{
  Client client = Client();

  /*
  since we use async and await, the return type must be future (wrap this return type with a future)
   */
  Future<List<int>> fetchTopIds() async{
    final response = await client.get('$_root/topstories.json?print=pretty');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async{
    final response = await client.get('$_root/item/$id.json?');
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}