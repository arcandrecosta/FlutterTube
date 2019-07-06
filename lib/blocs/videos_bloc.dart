import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos/api.dart';
import 'package:favoritos/models/video.dart';
import 'dart:async';

class VideosBloc implements BlocBase{
  Api api;
  List<Video> videos;

  final _videoController = StreamController<List<Video>>();
  Stream get outVideos => _videoController.stream;

  final _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  VideosBloc()  {
    api = Api();
     _searchController.stream.listen(_search);
  }

  _search(String search) async {  
    if(search != null){
       _videoController.sink.add([]);
      videos = await api.search(search);
    } else{
      videos += await api.nextPage();
    }   
   _videoController.sink.add(videos);
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoController.close();
    _searchController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }

}