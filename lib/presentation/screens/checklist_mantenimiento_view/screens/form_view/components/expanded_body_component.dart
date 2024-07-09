import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/form_view/form_view_model/form_view_model.dart';
import 'package:gap/gap.dart';

import 'components.dart';

class ExpandedBodyComponent extends ConsumerWidget {
  final int index;
  const ExpandedBodyComponent({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (images) =
        ref.watch(formViewModelProvider.select((value) => value.questions[index].images));
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Descripciónes',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final heightC = constraints.maxHeight;
                final width = constraints.maxWidth / 4;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0),
                  child: Row(
                    children: [
                      if (images.length < 6)
                      ContainerAddImageComponent(
                        height: heightC,
                        width: width,
                        index: index,
                      ),
                      const Gap(10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: images.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, indexImage) => ContainerImageComponent(
                            image: images[indexImage],
                            height: heightC,
                            width: width,
                            onDelete: () => ref
                                .read(formViewModelProvider.notifier)
                                .deleteImage(index, indexImage),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
