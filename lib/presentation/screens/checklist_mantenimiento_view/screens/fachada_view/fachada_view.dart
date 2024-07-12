import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/hooks/use_launch_effect.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/fachada_view/fachada_view_model/fachada_view_model.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/components.dart';

class FachadaView extends HookConsumerWidget {
  final String folio;
  const FachadaView({super.key, required this.folio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useLaunchEffect(
      () => ref.read(fachadaViewModelProvider.notifier).getFachada(folio),
    );
    final orientation = MediaQuery.of(context).orientation;

    final (isLoading) = ref.watch(
      fachadaViewModelProvider.select(
        (value) => (value.isLoading),
      ),
    );
    return Scaffold(
      body: Center(
        child: !isLoading ? orientation == Orientation.landscape
            ? const FachadaViewLandScape()
            : const FachadaViewPortrait()
            : const CircularProgressIndicator(),
      ),
    );
  }
}

class FachadaViewLandScape extends StatelessWidget {
  const FachadaViewLandScape({super.key});

  @override
  Widget build(BuildContext context) {
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
                    LabelMarcaComponent(),
                    Gap(10),
                    LabelRegionComponent(),
                    Gap(10),
                    LabelTipoSucursalComponent(),
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
    final image = ref.watch(fachadaViewModelProvider.select((value) => (value.imagePath)));
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
                          const LabelMarcaComponent(),
                          const Gap(10),
                          const LabelRegionComponent(),
                          const Gap(10),
                          const LabelTipoSucursalComponent(),
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
