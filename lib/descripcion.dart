import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String year;
  final String director;
  final String genre;
  final String synopsis;
  final String imageUrl;

  Movie({
    required this.title,
    required this.year,
    required this.director,
    required this.genre,
    required this.synopsis,
    required this.imageUrl,
  });
}

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Título: ${movie.title}', style: TextStyle(fontSize: 24)),
            Text('Año: ${movie.year}', style: TextStyle(fontSize: 20)),
            Text('Director: ${movie.director}', style: TextStyle(fontSize: 20)),
            Text('Género: ${movie.genre}', style: TextStyle(fontSize: 20)),
            Text('Sinopsis: ${movie.synopsis}', style: TextStyle(fontSize: 20)),
            Image.network(movie.imageUrl),
          ],
        ),
      ),
    );
  }
}