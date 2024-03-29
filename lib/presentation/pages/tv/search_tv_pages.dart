import 'package:movietv/common/constants.dart';
import 'package:movietv/common/state_enum.dart';
import 'package:movietv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movietv/presentation/bloc/tv/tv_bloc.dart';

class SearchTvPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<TvSearchBloc>().add(FetchTvsSearch(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<TvSearchBloc, TvState>(
              builder: (context, state) {
                if (state is TvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvHasData) {
                  final result = state.tvs;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tv = result[index];
                        return TvCard(tv);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is TvHasError) {
                  return Expanded(
                    child: Container(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
