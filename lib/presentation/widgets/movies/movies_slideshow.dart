import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 220,
      width: double.infinity,
      // Este widget de swiper es para hacer el slide con card
      child: Swiper(
          viewportFraction: 0.8,
          scale: 0.9,
          autoplay: true,
          pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
              activeColor: colors.primary,
              color: colors.secondary 
            ) 
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) => _Slide(movie: movies[index])),
    );
  }
}

// Este widget es cada diaposivita que mostrara una pelicula
class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    const decoration = BoxDecoration(boxShadow: [
      BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 10)),
    ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
          decoration: decoration,
          // Cliprrrect es para agg border radius
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.backdropPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const DecoratedBox(
                        decoration: BoxDecoration(
                      color: Colors.black12,
                    ));
                  }
                  return FadeIn(child: child);
                },
              ))),
    );
  }
}
