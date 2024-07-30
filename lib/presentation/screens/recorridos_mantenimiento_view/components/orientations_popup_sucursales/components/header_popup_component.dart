import 'package:flutter/material.dart';
import 'package:form_without_internet/constants/icons_manager.dart';
import 'package:form_without_internet/constants/strings_manager.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/components/components.dart';
import 'package:gap/gap.dart';

class HeaderPopupComponent extends StatelessWidget {
  final int index;
  final Color color;
  const HeaderPopupComponent({super.key, required this.index, required this.color});

  @override
  Widget build(BuildContext context) {
    return LabelContentComponent(
      label: 'Recorridos:',
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            IconsManager.iconsStatusAssigment[index],
            color: color,
          ),
          const Gap(5),
          Text(
            StringsManager.sucursalesColumn[index],
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
