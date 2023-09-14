import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>(
  (ref) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider).isEmpty;
    final moviesSlideshow = ref.watch(moviesSlideShowProvider).isEmpty;
    final popularMovies = ref.watch(popularMoviesProvider).isEmpty;
    final topRatedMovies = ref.watch(topRatedMoviesProvider).isEmpty;
    final upcomingMovies = ref.watch(upcomingMoviesProvider).isEmpty;

    if (nowPlayingMovies ||
        moviesSlideshow ||
        popularMovies ||
        topRatedMovies ||
        upcomingMovies) {
      return true;
    }

    return false;
  },
);
