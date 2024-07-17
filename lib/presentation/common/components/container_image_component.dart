import 'dart:io';

import 'package:flutter/material.dart';

class ContainerImageComponent extends StatelessWidget {
  final void Function()? onDelete;
  final String image;
  final double height;
  final double? width;
  final void Function()? onTap;
  final bool onTapped;
  final BoxFit boxFit;
  const ContainerImageComponent({
    super.key,
    required this.onDelete,
    required this.image,
    required this.height,
    required this.width,
    this.onTap,
    this.onTapped = true,
    this.boxFit = BoxFit.cover,
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
              onTap: onTap,
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    filterQuality: FilterQuality.high,
                    image: FileImage(File(image)),
                    fit: boxFit,
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
