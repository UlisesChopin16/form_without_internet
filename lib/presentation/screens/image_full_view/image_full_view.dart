import 'dart:io';

import 'package:flutter/material.dart';

class ImageFullView extends StatelessWidget {
  final String image;
  const ImageFullView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.8;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Image Full View'),
      ),
      body: Center(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: FileImage(
                File(
                  image,
                ),
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
