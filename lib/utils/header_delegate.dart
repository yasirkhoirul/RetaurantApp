import 'package:flutter/material.dart';

class Headerlistrestorandelegate extends SliverPersistentHeaderDelegate {
  final double maxheight;
  final double minheight;
  final Widget anak;

  Headerlistrestorandelegate({
    required this.anak,
    required this.maxheight,
    required this.minheight,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return anak;
  }

  @override
  double get maxExtent => maxheight;

  @override
  double get minExtent => minheight;

  @override
  bool shouldRebuild(covariant Headerlistrestorandelegate oldDelegate) {
    return maxheight != oldDelegate.maxheight ||
        minheight != oldDelegate.minheight ||
        anak != oldDelegate.anak;
  }
}
