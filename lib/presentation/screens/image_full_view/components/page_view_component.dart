import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/screens/checklist_mantenimiento_view/screens/form_view/components/components.dart';
import 'package:form_without_internet/presentation/screens/image_full_view/image_full_view_model/image_full_view_model.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageViewComponent extends ConsumerStatefulWidget {
  final void Function(int)? onDelete;
  final bool isDelete;
  const PageViewComponent({
    super.key,
    this.onDelete,
    this.isDelete = true,
  });

  @override
  ConsumerState<PageViewComponent> createState() => _PageViewComponentState();
}

class _PageViewComponentState extends ConsumerState<PageViewComponent> {
  late final PageController _pageController =
      PageController(initialPage: ref.read(imageFullViewModelProvider).index);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final (images, indexImage) = ref.watch(
      imageFullViewModelProvider.select(
        (value) => (value.images, value.index),
      ),
    );
    return SizedBox(
      height: height,
      width: width,
      child: Row(
        children: [
          PreviousButtonComponent(
            onPressed: _onPreviousButtonPressed,
          ),
          const Gap(10),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: ref.read(imageFullViewModelProvider.notifier).onChangeImage,
                    itemBuilder: (context, index) {
                      return ContainerImageComponent(
                        isDelete: widget.isDelete,
                        boxFit: BoxFit.cover,
                        onDelete: () {
                          ref
                              .read(imageFullViewModelProvider.notifier)
                              .deleteImage(onDelete: widget.onDelete, indexI: index);
                        },
                        image: images[index],
                        height: height - 55,
                        width: width - 110,
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (index) => Container(
                      margin: const EdgeInsets.all(5),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: index == indexImage ? Colors.black : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          NextButtonComponent(
            onPressed: _onNextButtonPressed,
          ),
        ],
      ),
    );
  }

  void _onNextButtonPressed() {
    if (_pageController.page == ref.read(imageFullViewModelProvider).images.length - 1) {
      _pageController.jumpToPage(
        0,
      );
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPreviousButtonPressed() {
    if (_pageController.page == 0) {
      _pageController.jumpToPage(
        ref.read(imageFullViewModelProvider).images.length - 1,
      );
      return;
    }
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

class NextButtonComponent extends StatelessWidget {
  final void Function() onPressed;
  const NextButtonComponent({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

class PreviousButtonComponent extends StatelessWidget {
  final void Function() onPressed;
  const PreviousButtonComponent({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
