import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

CachedNetworkImage cacheimage(String imageurl,{double width=50,double height=50}) {
  return CachedNetworkImage(
    imageUrl: imageurl,
    width: width,
    height: height,
    progressIndicatorBuilder: (context, val, progress) =>
        CircularProgressIndicator(
      value: progress.progress,
    ),
    errorWidget: (context, val1, val2) => Icon(
      Icons.error,
      color: Colors.red,
    ),
  );
}
