import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String imageUrl;

  Movie({required this.title, required this.imageUrl});
}

class CatalogScreen extends StatelessWidget {
 final List<Movie> movies = [
  Movie(title: 'The Great Train Robbery', imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/73/The_Great_Train_Robbery_%281903%29.webm.jpg'),
  Movie(title: 'A Trip to the Moon', imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/2/25/A_Trip_to_the_Moon_%28George_M%C3%A9li%C3%A8s%29.jpg'),
  // ...
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de películas'),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(movies[index].imageUrl),
            title: Text(movies[index].title),
          );
        },
      ),
    );
  }
}