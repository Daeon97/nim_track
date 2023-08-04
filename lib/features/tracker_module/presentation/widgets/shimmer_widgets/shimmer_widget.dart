// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    this.stopShimmer = false,
    this.radius = spacing,
    this.child,
    super.key,
  });

  final bool stopShimmer;
  final double radius;
  final Widget? child;

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        loop: stopShimmer ? veryTinySpacing.toInt() : nil.toInt(),
        baseColor: stopShimmer
            ? Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(
                  shimmerBaseColorOpacity,
                )
            : Theme.of(context).scaffoldBackgroundColor.withOpacity(
                  shimmerBaseColorOpacity,
                ),
        highlightColor: Theme.of(context).textTheme.bodyLarge!.color!,
        period: const Duration(
          milliseconds: shimmerDurationMilliseconds,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(
              radius,
            ),
            color: stopShimmer
                ? Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(
                      shimmerBaseColorOpacity,
                    )
                : Theme.of(context).scaffoldBackgroundColor.withOpacity(
                      shimmerBaseColorOpacity,
                    ),
          ),
          child: child,
        ),
      );
}
