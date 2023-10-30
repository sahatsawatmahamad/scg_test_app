import 'package:flutter/material.dart';

class ImageList extends StatelessWidget {
  const ImageList({required this.imageUrl, super.key});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return imageUrl != ""
        ? SizedBox(
            height: 200,
            width: MediaQuery.sizeOf(context).width,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container();
              },
            ),
          )
        : Container();
  }
}
