import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';

class NewsList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    //this is Bad, and temporary
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top news'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc){
    return StreamBuilder(
      stream: bloc.topIds,
      builder:(context, AsyncSnapshot<List<int>> snapshot){
        if(!snapshot.hasData){
          return Text("still wainting on");
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, int index){
            return Text('${snapshot.data[index]}');
          }
        );
      }
    );
  }
}