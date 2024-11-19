import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quadb_tv/core/utils/theme.dart';
import 'package:quadb_tv/presentation/bloc/bloc/episode_bloc.dart';
import 'package:quadb_tv/presentation/widgets/cast_card.dart';
import 'package:quadb_tv/presentation/widgets/episode_card.dart';
import '../../domain/entities/season.dart';
import '../../domain/entities/show.dart';
import '../../injection_container.dart';
import '../bloc/details/details_bloc.dart';
import '../widgets/error_view.dart';

class DetailsScreen extends StatefulWidget {
  final Show show;

  const DetailsScreen({
    super.key,
    required this.show,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int tabIndex = 0;

  void switchEpisodesTab() {
    if (tabIndex == 0) return;
    setState(() {
      tabIndex = 0;
    });
  }

  void switchCastTab() {
    if (tabIndex == 1) return;
    setState(() {
      tabIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DependencyInjection.sl<DetailsBloc>()
        ..add(LoadShowDetails(widget.show)),
      child: Material(
        child: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            return switch (state) {
              DetailsInitial() => const SizedBox(),
              DetailsLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              DetailsFailure(failure: final failure) => ErrorView(
                  message: failure.message,
                  onRetry: () => context
                      .read<DetailsBloc>()
                      .add(LoadShowDetails(widget.show)),
                ),
              DetailsSuccess(
                show: final show,
                cast: final casts,
                seasons: final seasons,
              ) =>
                Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SafeArea(
                          bottom: false,
                          child: SizedBox(
                            width: 375.w,
                            height: 210.h,
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: show.originalImageUrl ??
                                      show.mediumImageUrl ??
                                      '',
                                  width: 375.w,
                                  height: 210.h,
                                  fit: BoxFit.cover,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(Icons.arrow_back_ios)),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.play_circle_fill_rounded,
                                    size: 48.sp,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        BlocProvider<EpisodeBloc>(
                          create: (context) =>
                              DependencyInjection.sl<EpisodeBloc>()
                                ..add(
                                  LoadEpisodes(show: show, seasons: seasons),
                                ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.show.name,
                                  maxLines: 3,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      show.premiered ?? '2024',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    SizedBox(width: 8.w),
                                    Chip(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      padding: EdgeInsets.all(0.w),
                                      backgroundColor: Colors.white,
                                      label: Text(
                                        'IMDb ${show.rating}/10',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10.sp),
                                      ),
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    SizedBox(width: 8.w),
                                    if (seasons.isNotEmpty)
                                      Text(
                                        '${seasons.length} Seasons',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Text(show.summary ?? 'No summary available'),
                                SizedBox(height: 16.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 16.w),
                                      child: TextButton(
                                        onPressed: switchEpisodesTab,
                                        style: TextButton.styleFrom(
                                          side: BorderSide(
                                            color: tabIndex == 0
                                                ? Colors.red
                                                : AppTheme.primaryColor,
                                          ),
                                          shape: LinearBorder.bottom(),
                                        ),
                                        child: Text(
                                          "Episodes",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 16.w),
                                      child: TextButton(
                                        onPressed: switchCastTab,
                                        style: TextButton.styleFrom(
                                          side: BorderSide(
                                            color: tabIndex == 1
                                                ? Colors.red
                                                : AppTheme.primaryColor,
                                          ),
                                          shape: LinearBorder.bottom(),
                                        ),
                                        child: Text(
                                          "Cast",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                tabIndex == 0
                                    ? BlocBuilder<EpisodeBloc, EpisodeState>(
                                        builder: (context, state) {
                                        return switch (state) {
                                          EpisodeInitial() => const SizedBox(),
                                          EpisodeLoading() => const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          EpisodeFailure(
                                            failure: final failure
                                          ) =>
                                            ErrorView(
                                              message: failure.message,
                                              onRetry: () => context
                                                  .read<EpisodeBloc>()
                                                  .add(LoadEpisodes(
                                                    show: show,
                                                    seasons: seasons,
                                                  )),
                                            ),
                                          EpisodeSuccess(
                                            episodes: final episodes,
                                            currentSeason: final currentSeason,
                                          ) =>
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                currentSeason == null
                                                    ? Text(
                                                        'Episodes',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelLarge,
                                                      )
                                                    : seasons.length == 1
                                                        ? Text(
                                                            'Season ${currentSeason.number}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelLarge,
                                                          )
                                                        : DropdownButton<
                                                            Season>(
                                                            value:
                                                                currentSeason,
                                                            items: seasons
                                                                .map((season) {
                                                              return DropdownMenuItem(
                                                                value: season,
                                                                child: Text(
                                                                  'Season ${season.number}',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelLarge,
                                                                ),
                                                              );
                                                            }).toList(),
                                                            onChanged:
                                                                (season) {
                                                              context
                                                                  .read<
                                                                      EpisodeBloc>()
                                                                  .add(
                                                                    LoadSeasonEpisodes(
                                                                      season:
                                                                          season!,
                                                                    ),
                                                                  );
                                                            },
                                                          ),
                                                SizedBox(height: 8.h),
                                                Column(children: [
                                                  ...episodes
                                                      .where((i) =>
                                                          i.episode != null)
                                                      .toList()
                                                      .map(
                                                        (episode) =>
                                                            EpisodeCard(
                                                                episode:
                                                                    episode),
                                                      )
                                                ]),
                                              ],
                                            ),
                                        };
                                      })
                                    : GridView.count(
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.all(0),
                                        crossAxisSpacing: 8.sp,
                                        mainAxisSpacing: 8.sp,
                                        crossAxisCount: 3,
                                        childAspectRatio: 3 / 5,
                                        shrinkWrap: true,
                                        children: casts
                                            .map((cast) => CastCard(cast: cast))
                                            .toList(),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            };
          },
        ),
      ),
    );
  }
}
