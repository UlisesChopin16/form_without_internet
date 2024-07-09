import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_without_internet/presentation/common/components/label_text_component.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view_model/fachada_view_model.dart';
import 'package:gap/gap.dart';

import 'components/components.dart';

class FachadaView extends ConsumerWidget {
  const FachadaView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(fachadaViewModelProvider.select((value) => (value.imagePath)));
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Center(
        child: orientation == Orientation.landscape
            ? const FachadaViewLandScape()
            : const FachadaViewPortrait(),
      ),
    );
  }
}

class FachadaViewLandScape extends ConsumerWidget {
  const FachadaViewLandScape({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    return Row(
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContainerPhotoComponent(),
                    LabelTextComponent(
                      label: 'Marca',
                      text: 'Laboratorio Médico del CHOPO',
                      fontSize: 14,
                    ),
                    Gap(10),
                    LabelTextComponent(
                      label: 'Región',
                      text: 'QUERETARO',
                      fontSize: 14,
                    ),
                    Gap(10),
                    LabelTextComponent(
                      label: 'Tipo sucursal',
                      text: 'Consultorio',
                      fontSize: 14,
                    ),
                    Gap(20),
                    TextFieldGerenteComponent(),
                    Gap(10),
                    TextFieldContactoComponent(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
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
    );
  }
}

class FachadaViewPortrait extends ConsumerWidget {
  const FachadaViewPortrait({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    final (image, marca, region, tipoSucursal) = ref.watch(fachadaViewModelProvider
        .select((value) => (value.imagePath, value.marca, value.region, value.tipoSucursal)));
    return Column(
      children: [
        Expanded(
          child: Center(
            child: SingleChildScrollView(
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
                          Text('Marca: $marca'),
                          const Gap(10),
                          Text('Región: $region'),
                          const Gap(10),
                          Text('Tipo sucursal: $tipoSucursal'),
                          const Gap(30),
                          const TextFieldGerenteComponent(),
                          const Gap(10),
                          const TextFieldContactoComponent(),
                          if (image.isNotEmpty) const Gap(80) else const Gap(10),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
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
      ],
    );
  }
}
