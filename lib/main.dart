import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos/blocs/favorite_bloc.dart';
import 'package:favoritos/screens/Home.dart';
import 'package:flutter/material.dart';
import 'blocs/videos_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutterTube',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}
