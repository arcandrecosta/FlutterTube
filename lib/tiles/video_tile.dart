import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos/blocs/favorite_bloc.dart';
import 'package:favoritos/models/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:favoritos/api.dart';

class VideoTile extends StatelessWidget {
  final Video _video;
  VideoTile(this._video);
  @override
  Widget build(BuildContext context) {
    final FavoriteBloc _favoriteBloc  =  BlocProvider.getBloc<FavoriteBloc>();
    return GestureDetector(
      onTap: (){
        FlutterYoutube.playYoutubeVideoById(
          apiKey: API_KEY,
          videoId: _video.id,
        );
      },
      child: Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(
              _video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(
                        _video.title,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        _video.channel,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
              StreamBuilder<Map<String, Video>>(
                stream: _favoriteBloc.outFav,
                initialData: {},
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                      return IconButton(
                    icon: Icon(snapshot.data.containsKey(_video.id) ? Icons.star : Icons.star_border),
                    color: Colors.white,
                    iconSize: 30,
                    onPressed: () {
                      _favoriteBloc.toogleFavorite(_video);
                    },
                  );
                  }else{
                    return CircularProgressIndicator();
                  }
                
                },
              ),
            ],
          )
        ],
      ),
    ),
    );
  }
}
