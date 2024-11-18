import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/constants/size_constants.dart';
import '../../core/utils/theme.dart';
import '../../domain/entities/show.dart';

class ShowCard extends StatelessWidget {
  final Show show;
  final VoidCallback onTap;

  const ShowCard({
    super.key,
    required this.show,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(Sizes.spaceSmall),
        decoration: BoxDecoration(
          color: AppTheme.secondaryColor,
          borderRadius: BorderRadius.circular(Sizes.defaultRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (show.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Sizes.defaultRadius),
                ),
                child: CachedNetworkImage(
                  imageUrl: show.imageUrl!,
                  height: Sizes.thumbnailHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(Sizes.spaceSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    show.name,
                    style: AppTheme.titleStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (show.rating != null) ...[
                    SizedBox(height: Sizes.spaceXSmall),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: Sizes.iconSmall,
                          color: Colors.amber,
                        ),
                        SizedBox(width: Sizes.spaceXSmall),
                        Text(
                          show.rating.toString(),
                          style: AppTheme.bodyStyle,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
