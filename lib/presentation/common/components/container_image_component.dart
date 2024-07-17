import 'dart:io';

import 'package:flutter/material.dart';

class ContainerImageComponent extends StatelessWidget {
  final void Function()? onDelete;
  final String image;
  final double height;
  final double? width;
  final void Function()? onTap;
  final BoxFit boxFit;
  final bool isDelete;
  const ContainerImageComponent({
    super.key,this.onDelete,
    required this.image,
    required this.height,
    required this.width,
    this.onTap,
    this.boxFit = BoxFit.cover,
    this.isDelete = true,
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
          if (isDelete)
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
