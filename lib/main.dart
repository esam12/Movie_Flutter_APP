import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movieapp/data/core/api_client.dart';
import 'package:movieapp/data/data_sources/movie_remote_data_source.dart';
import 'package:movieapp/data/repositories/movie_repository_impl.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecases/get_trending.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ApiClient _client = ApiClient(Client());
  MovieRemoteDataSource dataSource = MovieRemoteDataSourceImpl(client: _client);
  MovieRepository repository = MovieRepositoryImpl(dataSource);
  GetTrending usecase = GetTrending(repository);
  final Either<AppError, List<MovieEntity>> 
      eitherResponse = await usecase(NoParams());

  eitherResponse.fold((l) => print(l), (r) => print(r));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Container(),
    );
  }
}
