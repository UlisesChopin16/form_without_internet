import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ContainerPhotoComponent(),
                    const Text('Marca: Laboratorio Médico del CHOPO'),
                    const Gap(10),
                    const Text('Región: QUERETARO'),
                    const Gap(10),
                    const Text('Tipo sucursal: Consultorio'),
                    const Gap(20),
                    TextFormField(
                      // keyboard.next
                      decoration: const InputDecoration(
                        labelText: 'Gerente de sucursal',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const Gap(10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'No. de contacto',
                        hintText: 'Teléfono o celular',
                        border: OutlineInputBorder(),
                      ),
                    ),
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
    final (image) = ref.watch(fachadaViewModelProvider.select((value) => (value.imagePath)));
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
                          const Text('Marca: Laboratorio Médico del CHOPO'),
                          const Gap(10),
                          const Text('Región: QUERETARO'),
                          const Gap(10),
                          const Text('Tipo sucursal: Consultorio'),
                          const Gap(30),
                          TextFormField(
                            // keyboard.next
                            decoration: const InputDecoration(
                              labelText: 'Gerente de sucursal',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const Gap(10),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'No. de contacto',
                              hintText: 'Teléfono o celular',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          if (image.isNotEmpty)
                          const Gap(80)
                          else const Gap(10),
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
