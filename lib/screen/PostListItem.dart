import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/post.dart';


class PostListItem extends StatelessWidget {
  const PostListItem({required this.post, super.key});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final currentTime = TimeOfDay.now();
      return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      decoration: BoxDecoration(
        color: currentTime.hour >= 6 && currentTime.hour < 18 ? Color(0xFFFFFFFF) : Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: AspectRatio(
              aspectRatio: 16 / 6,
              child: CachedNetworkImage(
                imageUrl: post.photo,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.fill
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(post.name, style: TextStyle(fontSize: 19.0,fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                ),
                post.isFavorite ? Icon(Icons.favorite, color: Colors.blue) : Icon(Icons.favorite_border, color: Colors.blue)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Row(
              children: [
                post.rate>0.0 ? Icon(Icons.star, color: Colors.blue) : Icon(Icons.star, color: Colors.grey),
                SizedBox(width: 5.0),
                Text(post.rate.toStringAsFixed(1),style: TextStyle(fontSize: 16.0, color: Colors.blue, fontWeight: FontWeight.bold,)),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(post.cuisines.join().replaceAll(" ", ", "), style: TextStyle(fontSize: 16.0, color: Colors.grey, fontWeight: FontWeight.bold),maxLines: 2, overflow: TextOverflow.ellipsis),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}