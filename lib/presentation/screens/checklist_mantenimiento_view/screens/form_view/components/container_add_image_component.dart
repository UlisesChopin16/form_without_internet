import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_without_internet/presentation/screens/camera_view/camera_view.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/form_view/form_view_model/form_view_model.dart';

class ContainerAddImageComponent extends ConsumerWidget {
  final int index;
  final double height;
  final double width;
  const ContainerAddImageComponent(
      {super.key, required this.height, required this.width, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images =
        ref.watch(formViewModelProvider.select((value) => value.questions[index].images));
    return InkWell(
      onTap: () => onTap(context, ref),
      child: Card(
        elevation: 5,
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(right: 10, top: 10),
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_a_photo,
                size: 65,
              ),
              Text(
                '${images.length}/6',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onTap(BuildContext context, WidgetRef ref) async {
    final path = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CameraView(),
      ),
    );
    if (path != null) {
      ref.read(formViewModelProvider.notifier).addImage(index, path);
    }
  }
}
