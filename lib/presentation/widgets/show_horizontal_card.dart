import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/routes.dart';
import '../../domain/entities/show.dart';

class ShowHorizontalCard extends StatelessWidget {
  final Show show;
  const ShowHorizontalCard({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.details,
              arguments: show,
            );
          },
          child: SizedBox(
            width: 359.w,
            height: 54.h,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedNetworkImage(
                    imageUrl:
                        show.originalImageUrl ?? show.mediumImageUrl ?? '',
                    width: 96.w,
                    height: 54.h,
                    errorWidget: (context, url, error) => Container(
                      color: Colors.white70,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 24.w),
                Text(
                  show.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Spacer(),
                Icon(
                  Icons.play_circle_outline_outlined,
                  size: 36.r,
                ),
              ],
            ),
          )),
    );
  }
}
