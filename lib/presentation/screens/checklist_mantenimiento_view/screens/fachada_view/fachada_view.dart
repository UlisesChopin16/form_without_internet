import 'package:flutter/material.dart';
import 'package:form_without_internet/domain/models/recorridos_mantenimiento_response_model/recorridos_mantenimiento_response_model.dart';
import 'package:form_without_internet/presentation/hooks/use_launch_effect.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view_model/fachada_view_model.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/components.dart';

class FachadaView extends HookConsumerWidget {
  final RecorridoSucursalModel recorrido;
  final bool isResume;
  final EdgeInsets viewInsets;
  const FachadaView(
      {super.key,
      required this.recorrido,
      required this.isResume,
      this.viewInsets = EdgeInsets.zero});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useLaunchEffect(
      () => ref.read(fachadaViewModelProvider.notifier).getFachada(
            isResume,
            recorrido,
          ),
    );
    final orientation = MediaQuery.of(context).orientation;

    final (isLoading) = ref.watch(
      fachadaViewModelProvider.select(
        (value) => (value.isLoading),
      ),
    );
    return Scaffold(
      body: Center(
        child: !isLoading
            ? LayoutBuilder(
                builder: (context, constraints) {
                  final height = constraints.maxHeight;
                  final width = constraints.maxWidth;
                  return orientation == Orientation.landscape
                      ? FachadaViewLandScape(
                          height,
                          width,
                          viewInsets,
                        )
                      : FachadaViewPortrait(
                          height,
                          width,
                          viewInsets,
                        );
                },
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}

class FachadaViewLandScape extends ConsumerWidget {
  final double widht;
  final double height;
  final EdgeInsets viewInsets;
  const FachadaViewLandScape(
    this.height,
    this.widht,
    this.viewInsets, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (image, isResume) = ref.watch(
      fachadaViewModelProvider.select(
        (value) => (value.imagePath, value.isResume),
      ),
    );
    return ListView(
      children: [
        Row(
          children: [
            SizedBox(
              width: widht * 0.5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ContainerPhotoComponent(),
                      if (image.isEmpty || isResume) const Gap(30),
                      const LabelMarcaComponent(),
                      const Gap(10),
                      const LabelRegionComponent(),
                      const Gap(10),
                      const LabelTipoSucursalComponent(),
                      const Gap(20),
                      const TextFieldGerenteComponent(),
                      const Gap(10),
                      const TextFieldContactoComponent(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: widht * 0.5,
              height: height + viewInsets.bottom,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FachadaViewPortrait extends ConsumerWidget {
  final double height;
  final double width;
  final EdgeInsets viewInsets;
  const FachadaViewPortrait(this.height, this.width, this.viewInsets, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (image, isResume) =
        ref.watch(fachadaViewModelProvider.select((value) => (value.imagePath, value.isResume)));
    return ListView(
      children: [
        SizedBox(
          height: (height * 0.5) + (viewInsets.bottom * 0.5),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Expanded(
                    child: ContainerPhotoComponent(),
                  ),
                  const Gap(30),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const LabelMarcaComponent(),
                        const Gap(10),
                        const LabelRegionComponent(),
                        const Gap(10),
                        const LabelTipoSucursalComponent(),
                        const Gap(30),
                        const TextFieldGerenteComponent(),
                        const Gap(10),
                        const TextFieldContactoComponent(),
                        if (image.isNotEmpty && !isResume) const Gap(80) else const Gap(10),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: (height * 0.5) + (viewInsets.bottom * 0.5),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 15.0,
              right: 15.0,
              left: 15.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        const Gap(50),
      ],
    );
  }
}
