import 'package:cached_network_image/cached_network_image.dart';
import 'package:movietv/common/constants.dart';
import 'package:movietv/domain/entities/tv/tv.dart';
import 'package:movietv/presentation/pages/tv/now_playing_tv_page.dart';
import 'package:movietv/presentation/pages/about_page.dart';
import 'package:movietv/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:movietv/presentation/pages/tv/search_tv_pages.dart';
import 'package:movietv/presentation/pages/tv/tv_detail_page.dart';
import 'package:movietv/presentation/pages/tv/popular_tv_page.dart';
import 'package:movietv/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:movietv/presentation/pages/tv/watchlist_tvs_page.dart';
import 'package:movietv/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietv/presentation/bloc/tv/tv_bloc.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv';

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTvsBloc>().add(FetchNowPlayingTvs());
      context.read<PopularTvsBloc>().add(FetchPopularTvs());
      context.read<TopRatedTvsBloc>().add(FetchTopRatedTvs());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                // Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Tv Series'),
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, HomeTvPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Movies'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Tv Series'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvsPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Tv Series'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pop(context);
              Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
              title: 'Now Playing',
              onTap: () =>
                  Navigator.pushNamed(context, NowPlayingTvPage.ROUTE_NAME),
            ),
            BlocBuilder<NowPlayingTvsBloc, TvState>(builder: (context, state) {
              if (state is TvLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TvHasData) {
                return TvList(state.tvs);
              } else if (state is TvHasError) {
                return Text(state.message);
              } else {
                return Text('failed');
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvsPage.ROUTE_NAME),
            ),
            BlocBuilder<PopularTvsBloc, TvState>(builder: (context, state) {
              if (state is TvLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TvHasData) {
                return TvList(state.tvs);
              } else if (state is TvHasError) {
                return Text(state.message);
              } else {
                return Text('failed');
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvsPage.ROUTE_NAME),
            ),
            BlocBuilder<TopRatedTvsBloc, TvState>(builder: (context, state) {
              if (state is TvLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TvHasData) {
                return TvList(state.tvs);
              } else if (state is TvHasError) {
                return Text(state.message);
              } else {
                return Text('failed');
              }
            }),
          ],
        )),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  TvList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
