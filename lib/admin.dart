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

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _yearController = TextEditingController();
  final _directorController = TextEditingController();
  final _genreController = TextEditingController();
  final _synopsisController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrar películas'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el título';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _yearController,
              decoration: InputDecoration(labelText: 'Año'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el año';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _directorController,
              decoration: InputDecoration(labelText: 'Director'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el director';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _genreController,
              decoration: InputDecoration(labelText: 'Género'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el género';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _synopsisController,
              decoration: InputDecoration(labelText: 'Sinopsis'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa la sinopsis';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'URL de la imagen'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa la URL de la imagen';
                }
                return null;
              },
            ),
            ElevatedButton(
  child: Text('Agregar película'),
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      // Crear una nueva película con los datos del formulario
      Movie newMovie = Movie(
        title: _titleController.text,
        year: _yearController.text,
        director: _directorController.text,
        genre: _genreController.text,
        synopsis: _synopsisController.text,
        imageUrl: _imageUrlController.text,
      );

      // Agregar la nueva película a la lista de películas
      // Nota: necesitarás tener una lista de películas en tu estado
      setState(() {
        movies.add(newMovie);
      });

      // Limpiar el formulario
      _titleController.clear();
      _yearController.clear();
      _directorController.clear();
      _genreController.clear();
      _synopsisController.clear();
      _imageUrlController.clear();
    }
  },
),
            ],
            ),
        ),
        );
    }
    }   