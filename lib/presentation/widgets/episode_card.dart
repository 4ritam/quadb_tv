import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/episode.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;
  const EpisodeCard({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343.w,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 69.h,
                  width: 124.w,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: episode.imageUrl ?? '',
                        height: 69.h,
                        width: 124.w,
                        errorWidget: (context, url, error) => Container(
                          color: Colors.white70,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.play_circle_filled_rounded),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 203.w,
                        child: Text(
                          '${episode.episode}. ${episode.name}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      Text(
                        '${episode.runtime}',
                        style: Theme.of(context).textTheme.labelSmall,
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                episode.summary ?? 'Description Not Available',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.start,
              ),
            )
          ],
        ),
      ),
    );
  }
}
