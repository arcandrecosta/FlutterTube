import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos/blocs/favorite_bloc.dart';
import 'package:favoritos/blocs/videos_bloc.dart';
import 'package:favoritos/delegates/data_search.dart';
import 'package:favoritos/tiles/video_tile.dart';
import 'package:flutter/material.dart';

import 'favorites_screen.dart';

class Home extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final VideosBloc _videosBloc  =  BlocProvider.getBloc<VideosBloc>();
    final FavoriteBloc _favoriteBloc  =  BlocProvider.getBloc<FavoriteBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/yt_logo_rgb_dark.png"),          
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              stream: _favoriteBloc.outFav,
              initialData: {},
              builder: (context,snapshot){
                if(snapshot.hasData)return Text("${snapshot.data.length}");
                else return Container();
              },
            ),
          ),          
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FavoritesScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result = await showSearch(context: context,delegate: DataSearch());         
              if(result != null) _videosBloc.inSearch.add(result);
            },
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder(
        stream: _videosBloc.outVideos,
        initialData: [],
         builder: (context,snapshot){
           if(snapshot.hasData)
           {
             return ListView.builder(               
               itemBuilder: (context,index){                 
                if(index < snapshot.data.length){
                   return VideoTile(snapshot.data[index]);
                }else if(index > 1){
                  _videosBloc.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),
                  );
                }else{
                  return Container();
                }
               },
               itemCount: snapshot.data.length + 1,
             );
           }else{
             return Container();
           }

         },
      ),
    );
  }
}