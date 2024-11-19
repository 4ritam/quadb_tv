import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/cast.dart';

class CastCard extends StatelessWidget {
  final Cast cast;
  const CastCard({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: CachedNetworkImage(
            imageUrl: cast.person.imageUrl ?? '',
            fit: BoxFit.cover,
            width: 108.w,
            errorWidget: (context, url, error) => Container(
              color: Colors.white60,
              child: Expanded(
                child: Center(
                  child: Icon(
                    Icons.person_2,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              cast.person.name,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              cast.character.name,
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.start,
            ),
          ),
        )
      ],
    );
  }
}
