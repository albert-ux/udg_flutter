import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pokémon Flutter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PokemonBloc()..add(PokemonPageRequest(page: 0)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: PokemonView(),
      ),
    );
  }
}

class PokemonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoadInProgress) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PokemonPageLoadSuccess) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(state.pokemonListings[index].imageUrl),
                title: Text(state.pokemonListings[index].name),
              );
            },
            itemCount: state.pokemonListings.length,
          );
        } else if (state is PokemonPageLoadFailed) {
          return Center(child: Text(state.error));
        } else {
          return Center(child: Text('Unknown state'));
        }
      },
    );
  }
}

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc() : super(PokemonInitial()) {
    on<PokemonPageRequest>((event, emit) async {
      emit(PokemonLoadInProgress());
      try {
        final pokemonPageResponse = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=${event.page}&limit=20'));
        final pokemonPage = PokemonPage.fromJson(jsonDecode(pokemonPageResponse.body));
        emit(PokemonPageLoadSuccess(pokemonListings: pokemonPage.results));
      } catch (e) {
        emit(PokemonPageLoadFailed(error: e.toString()));
      }
    });
  }
}

abstract class PokemonEvent {}

class PokemonPageRequest extends PokemonEvent {
  final int page;

  PokemonPageRequest({required this.page});
}

abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoadInProgress extends PokemonState {}

class PokemonPageLoadSuccess extends PokemonState {
  final List<PokemonListing> pokemonListings;

  PokemonPageLoadSuccess({required this.pokemonListings});
}

class PokemonPageLoadFailed extends PokemonState {
  final String error;

  PokemonPageLoadFailed({required this.error});
}

class PokemonPage {
  final List<PokemonListing> results;

  PokemonPage({required this.results});

  factory PokemonPage.fromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List)
        .map((listingJson) => PokemonListing.fromJson(listingJson))
        .toList();

    return PokemonPage(results: results);
  }
}

class PokemonListing {
  final String name;
  final String imageUrl;

  PokemonListing({required this.name, required this.imageUrl});

  factory PokemonListing.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final imageUrl = json['sprites']['front_default'];

    return PokemonListing(name: name, imageUrl: imageUrl);
  }
}