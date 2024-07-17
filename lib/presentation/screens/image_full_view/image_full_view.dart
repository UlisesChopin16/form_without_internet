import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/hooks/use_launch_effect.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/form_view/components/components.dart';
import 'package:form_without_internet/presentation/screens/image_full_view/components/page_view_component.dart';
import 'package:form_without_internet/presentation/screens/image_full_view/image_full_view_model/image_full_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImageFullView extends HookConsumerWidget {
  final String image;
  final List<String> images;
  final int index;
  final bool isDelete;
  final void Function(int)? onDelete;

  const ImageFullView({
    super.key,
    this.image = '',
    this.images = const [],
    this.index = 0,
    this.onDelete,
    this.isDelete = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useLaunchEffect(
      () => ref
          .read(imageFullViewModelProvider.notifier)
          .setData(image: image, images: images, index: index),
    );

    final fullImages = ref.watch(imageFullViewModelProvider.select((value) => value.images));

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    const boxFit = BoxFit.fitWidth;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: fullImages.isEmpty || fullImages.length == 1
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ContainerImageComponent(
                    onDelete: () {
                      onDelete?.call(0);
                      if (fullImages.length == 1) {
                        Navigator.pop(context);
                      }
                    },
                    isDelete: isDelete,
                    image: (fullImages.length == 1) ? fullImages[0] : image,
                    height: height,
                    width: width,
                    boxFit: boxFit,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
                  child: PageViewComponent(
                    onDelete: onDelete,
                    isDelete: isDelete,
                  ),
                ),
        ),
      ),
    );
  }
}
