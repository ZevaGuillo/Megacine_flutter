import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottonNav(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideShowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

// El customScrollView tiene slivers, que son como los children de un column, pero con la diferencia que cada sliver tiene un scrollController

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: CustomAppbar(),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            // const CustomAppbar(),
            MoviesSlideshow(movies: moviesSlideshow),
            MovieHorizontalListView(
              movies: nowPlayingMovies,
              title: 'En Cines',
              subTitle: 'Lunes 20',
              // Metodo para hacer el scroll infinito, utilizado dentro del scrollController
              loadNextPage: () {
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              },
            ),
            MovieHorizontalListView(
              movies: upcomingMovies,
              title: 'Próximamente',
              subTitle: 'En este mes',
              // Metodo para hacer el scroll infinito, utilizado dentro del scrollController
              loadNextPage: () {
                ref.read(upcomingMoviesProvider.notifier).loadNextPage();
              },
            ),
            MovieHorizontalListView(
              movies: popularMovies,
              title: 'Populares',
              // subTitle: 'Lunes 20',
              // Metodo para hacer el scroll infinito, utilizado dentro del scrollController
              loadNextPage: () {
                ref.read(popularMoviesProvider.notifier).loadNextPage();
              },
            ),
            MovieHorizontalListView(
              movies: topRatedMovies,
              title: 'Mejor calificadas',
              subTitle: 'De todos los tiempos',
              // Metodo para hacer el scroll infinito, utilizado dentro del scrollController
              loadNextPage: () {
                ref.read(topRatedMoviesProvider.notifier).loadNextPage();
              },
            ),
            const SizedBox(height: 25)
          ],
        );
      }, childCount: 1))
    ]);
  }
}
