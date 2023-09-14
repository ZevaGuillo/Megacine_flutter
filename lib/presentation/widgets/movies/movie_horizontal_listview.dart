import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListView(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});

  @override
  State<MovieHorizontalListView> createState() =>
      _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {
  final scrollController = ScrollController();

  // Configuracionde inicial antes de montar el widget
  // En el caso de manejar controladores se deben definir los eventos principales
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  // El metodo dispose se usa cuando se destruye una pantalla, para limpiar las dependencias
  // Todos los controladores tienen un metodo dispose
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(children: [
        if (widget.title != null || widget.subTitle != null)
          _Title(
            title: widget.title,
            subTitle: widget.subTitle,
          ),
        Expanded(
            child: ListView.builder(
          controller: scrollController,
          itemCount: widget.movies.length,
          scrollDirection: Axis.horizontal,
          // TODO:
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            // ITEMS

            return Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: FadeInRight(child: _Slider(movie: widget.movies[index])),
            );
          },
        ))
      ]),
    );
  }
}

class _Slider extends StatelessWidget {
  final Movie movie;

  const _Slider({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* IMagen de la pelicula
          SizedBox(
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  width: 150,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const SizedBox(
                        height: 200,
                        child: DecoratedBox(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 10))
                          ], color: Colors.black12),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return FadeIn(child: child);
                  },
                ),
              )),

          //* TITULO
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),
          // const Spacer(),

          //* Rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  "${movie.voteAverage}",
                  style: textStyle.bodyMedium
                      ?.copyWith(color: Colors.yellow.shade800),
                ),
                const Spacer(),
                Text(
                  HumanFormats.humanReadbleNumber(movie.popularity),
                  style: textStyle.bodySmall,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
              onPressed: () {},
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              child: Text(subTitle!),
            )
        ],
      ),
    );
  }
}
