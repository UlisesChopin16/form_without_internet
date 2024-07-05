import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_without_internet/presentation/screens/camera_view/camera_view.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view_model/fachada_view_model.dart';
import 'package:gap/gap.dart';

class ContainerPhotoComponent extends ConsumerWidget {
  const ContainerPhotoComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.watch(fachadaViewModelProvider.select((value) => (value.imagePath)));
    final orientation = MediaQuery.of(context).orientation;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CameraView(),
              ),
            );
          },
          child: Container(
            height: orientation == Orientation.portrait ? 350 : 300,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Toma una foto de la fachada de la sucursal'),
                  Icon(Icons.add_a_photo, size: 65),
                ],
              ),
            ),
          ),
        ),
        const Gap(10),
        if (image.isNotEmpty)
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(bottom: orientation == Orientation.portrait ? 0 : 30),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_a_photo, size: 40),
                  Gap(10),
                  Text('Tomar una foto\nde la fachada'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}