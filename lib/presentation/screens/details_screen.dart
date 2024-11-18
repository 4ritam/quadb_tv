import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/show.dart';
import '../../injection_container.dart';
import '../bloc/details/details_bloc.dart';
import '../widgets/error_view.dart';

class DetailsScreen extends StatelessWidget {
  final Show show;

  const DetailsScreen({
    super.key,
    required this.show,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DependencyInjection.sl<DetailsBloc>()..add(LoadShowDetails(show)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(show.name),
        ),
        body: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            return switch (state) {
              DetailsInitial() => const SizedBox(),
              DetailsLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              DetailsSuccess(
                show: final show,
                episodes: final episodes,
                cast: final cast,
                seasonEpisodes: final seasonEpisodes,
                seasons: final seasons,
              ) =>
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (show.imageUrl != null)
                        Image.network(
                          show.imageUrl!,
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Summary',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(show.summary ?? 'No summary available'),
                            const SizedBox(height: 16),
                            Text(
                              'Episodes',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: seasons != null
                                    ? seasonEpisodes![seasons[0]]?.length
                                    : episodes?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final episode = seasons != null
                                      ? seasonEpisodes![seasons[0]]![index]
                                      : episodes![index];
                                  return Card(
                                    child: SizedBox(
                                      width: 160,
                                      child: Column(
                                        children: [
                                          if (episode.imageUrl != null)
                                            Image.network(
                                              episode.imageUrl!,
                                              height: 120,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              episode.name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Cast',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: cast.length,
                                itemBuilder: (context, index) {
                                  final castMember = cast[index];
                                  return Card(
                                    child: SizedBox(
                                      width: 120,
                                      child: Column(
                                        children: [
                                          if (castMember.person.imageUrl !=
                                              null)
                                            Image.network(
                                              castMember.person.imageUrl!,
                                              height: 120,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              castMember.person.name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              DetailsFailure(failure: final failure) => ErrorView(
                  message: failure.message,
                  onRetry: () =>
                      context.read<DetailsBloc>().add(LoadShowDetails(show)),
                ),
            };
          },
        ),
      ),
    );
  }
}
