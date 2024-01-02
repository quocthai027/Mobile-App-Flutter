import 'package:flutter/material.dart';

class PhotoDetailScreen extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const PhotoDetailScreen({required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết hình ảnh'),
        backgroundColor:
            Colors.transparent, // Đặt màu nền trong suốt cho AppBar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.orange],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: PageView.builder(
        itemCount: images.length,
        controller: PageController(initialPage: initialIndex),
        itemBuilder: (context, index) {
          return Container(
            child: Image.network(images[index]),
          );
        },
      ),
    );
  }
}
