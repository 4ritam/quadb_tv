import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/routes.dart';
import '../../domain/entities/show.dart';

class ShowVerticalCard extends StatelessWidget {
  final Show show;
  const ShowVerticalCard({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.details,
            arguments: show,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: AspectRatio(
            aspectRatio: 0.7,
            child: SizedBox(
              width: 104.w,
              child: CachedNetworkImage(
                imageUrl: show.originalImageUrl ?? show.mediumImageUrl ?? '',
                width: 104.w,
                errorWidget: (context, url, error) => Container(
                  color: Colors.white70,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ));
  }
}
