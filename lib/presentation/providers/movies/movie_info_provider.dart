
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este estado tiene comom objetivo guardar las peliculas en el cache asi
// {
//   '503430': 'Movie()',
//   '503430': 'Movie()',
//   '503430': 'Movie()',
// }

// final nowPlayingMoviesProvider =
//     StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
//   final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
//   return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
// });


final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {

  final movieRepository = ref.watch(movieRepositoryProvider);

  return MovieMapNotifier(getMovie: movieRepository.getMovieById);

});


// Definicion de un tipo, paara una funcion
typedef GetMovieCallBack = Future<Movie> Function(String movieID);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>>{
  final GetMovieCallBack getMovie;

  MovieMapNotifier({required this.getMovie}): super({});

  Future<void> loadMovie(String movieId) async{
    // En caso de no encontrar esta pelicula en el cache
    if(state[movieId] != null) return;

    final movie = await getMovie(movieId); 

    state = { ...state, movieId: movie  };

  }

}