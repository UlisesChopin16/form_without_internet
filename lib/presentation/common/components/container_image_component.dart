import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/screens/image_full_view/image_full_view.dart';

class ContainerImageComponent extends StatelessWidget {
  final void Function()? onDelete;
  final String image;
  final double height;
  final double width;
  const ContainerImageComponent({
    super.key,
    required this.onDelete,
    required this.image,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          Positioned(
            top: 12,
            left: 0,
            right: 0,
            bottom: 0,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ImageFullView(image: image),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: FileImage(File(image)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          // delete button
          Positioned(
            top: -5,
            right: -5,
            child: IconButton(
              icon: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete,
                ),
              ),
              onPressed: onDelete,
            ),
          )
        ],
      ),
    );
  }
}
